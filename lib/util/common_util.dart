/*
 * 是否初始化
 */
bool isLateInitialized(Function() accessVariable) {
  try {
    accessVariable();
    return true;
  } catch (e) {
    return false;
  }
}