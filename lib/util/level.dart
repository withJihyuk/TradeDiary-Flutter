class LevelSystem {
  final List<int> expThresholds = [15, 34, 57, 92, 135, 372];

  int getLevel(int exp) {
    int level = 1;
    int accumulatedExp = 0;

    for (int i = 0; i < expThresholds.length; i++) {
      accumulatedExp += expThresholds[i];
      if (exp < accumulatedExp) {
        return level;
      }
      level++;
    }
    return level;
  }

  int expToNextLevel(int exp) {
    int level = getLevel(exp);
    if (level > expThresholds.length) {
      return 0;
    }

    int accumulatedExp = 0;
    for (int i = 0; i < level - 1; i++) {
      accumulatedExp += expThresholds[i];
    }

    return (accumulatedExp + expThresholds[level - 1]) - exp;
  }
}
