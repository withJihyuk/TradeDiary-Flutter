"""Export artwork from capture.dart running on a dedicated simulator.

No account or backend access is needed. Raw OS screenshots stay in build/aso.
Native home-widget screenshots must be captured separately and passed as input.
"""

import argparse
from pathlib import Path
import subprocess
import urllib.request


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("platform", choices=["ios", "android"])
    parser.add_argument("device", help="simctl UUID or adb serial")
    parser.add_argument("--port", default=8765, type=int)
    parser.add_argument("--widget", type=Path, help="Actual native home-widget screenshot")
    parser.add_argument("--feature-graphic", action="store_true", help="Optional reference artwork; excluded from store application")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    output = root / "docs/aso/previews" / args.platform
    raw = root / "build/aso/raw" / args.platform
    output.mkdir(parents=True, exist_ok=True)
    raw.mkdir(parents=True, exist_ok=True)
    base = f"http://127.0.0.1:{args.port}"

    def request(path, data=None):
        req = urllib.request.Request(base + path, data=data)
        with urllib.request.urlopen(req, timeout=45) as response:
            return response.read()

    request("/photo", (root / "docs/aso/assets/sunset.png").read_bytes())
    scenes = [
        ("home", "01-growth"),
        ("emotion", "02-emotion"),
        ("photo", "03-photo"),
        ("diary", "05-search"),
        ("drafts", "06-drafts"),
    ]
    for scene, name in scenes:
        request(f"/scene/{scene}")
        shot = raw / f"{scene}.png"
        if args.platform == "ios":
            subprocess.run(["xcrun", "simctl", "io", args.device, "screenshot", str(shot)], check=True, capture_output=True)
        else:
            result = subprocess.run(["adb", "-s", args.device, "exec-out", "screencap", "-p"], check=True, capture_output=True)
            shot.write_bytes(result.stdout)
        (output / f"{name}.png").write_bytes(request(f"/render/{args.platform}/{scene}", shot.read_bytes()))
        print(f"Exported {args.platform}/{name}.png", flush=True)
    request('/scene/editor')
    editor = raw / 'editor.png'
    if args.platform == 'ios':
        subprocess.run(['xcrun', 'simctl', 'io', args.device, 'screenshot', str(editor)], check=True, capture_output=True)
    else:
        result = subprocess.run(['adb', '-s', args.device, 'exec-out', 'screencap', '-p'], check=True, capture_output=True)
        editor.write_bytes(result.stdout)
    request('/editor-shot', editor.read_bytes())
    (output / '06-drafts.png').write_bytes(request(f'/render/{args.platform}/drafts', (raw / 'drafts.png').read_bytes()))
    if args.widget:
        (output / "04-widget.png").write_bytes(request(f"/render/{args.platform}/widget", args.widget.read_bytes()))
        print(f"Exported {args.platform}/04-widget.png", flush=True)
    if args.platform == "android" and args.feature_graphic:
        (output.parent / "featureGraphic.png").write_bytes(request("/render/android/feature", b""))
        print("Exported featureGraphic.png", flush=True)


if __name__ == "__main__":
    main()
