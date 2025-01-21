class LevelSystem {
  // 각 레벨에 필요한 누적 경험치
  final List<int> levelExp = [15, 34, 57, 92, 135, 372];

  int getLevel(int exp) {
    for (int i = 0; i < levelExp.length; i++) {
      if (exp < levelExp[i]) {
        return i + 1;
      }
    }
    return levelExp.length + 1;
  }

  int expToNextLevel(int exp) {
    int currentLevel = getLevel(exp);
    if (currentLevel > levelExp.length) {
      return 0;
    }
    return levelExp[currentLevel - 1] -
        (currentLevel == 1 ? 0 : levelExp[currentLevel - 2]);
  }

  int getCurrentLevelExp(int level) {
    if (level <= 1) return 0;
    if (level > levelExp.length + 1) return levelExp.last;
    return levelExp[level - 2];
  }

  int getRemainingExp(int currentExp) {
    int currentLevel = getLevel(currentExp);
    if (currentLevel > levelExp.length) return 0;
    return levelExp[currentLevel - 1] - currentExp;
  }
}
