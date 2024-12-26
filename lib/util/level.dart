class LevelSystem {
  final List<int> expThresholds = [15, 34, 57, 92, 135, 372];
  final List<int> expRequired = [15, 34, 57, 92, 135, 372];

  int getLevel(int exp) {
    for (int i = 1; i < expThresholds.length; i++) {
      if (exp < expThresholds[i]) {
        return i;
      }
    }
    return expThresholds.length;
  }

  int expToNextLevel(int exp) {
    int currentLevel = getLevel(exp);
    if (currentLevel >= expThresholds.length) {
      return 0;
    }
    return expRequired[currentLevel + 1];
  }
}
