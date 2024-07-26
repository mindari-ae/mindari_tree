/// this class for comparing euqual class and objects in outside.
abstract class MindariEquality<T> {
  int equals(T other);
  int compareTo(T other);
  static int compare(MindariEquality a, MindariEquality b) => a.compareTo(b);
}

int mindariBinarySearch<T extends MindariEquality<Object>>(
    List<T> sortedList, T value) {
  int min = 0;
  int max = sortedList.length;
  while (min < max) {
    final int mid = min + ((max - min) >> 1);
    final T element = sortedList[mid];
    final int comp = element.compareTo(value);
    if (comp == 0) {
      return mid;
    }
    if (comp < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return -1;
}
