/*
*このファイルの内容不使用
*メモ用に残す
*/

/*
import java.util.AbstractList;
import java.util.AbstractSequentialList;
import java.util.Arrays;
import java.util.List;
import java.util.Iterator;
import java.util.ListIterator;

class MyList<E> extends AbstractList<E> {
  private Object[] elementData;
  private final Object[] EMPTY = {};
  private int DEFAULT_CAPACITY = 10;
  private int MAX_ARRAY_SIZE = 10000;
  private int size;//使用中の配列自体の長さ


  public MyList() {
    elementData = EMPTY;
  }
  public MyList(int minCapacity) {
    elementData = new Object[minCapacity];
  }

  //通常時
  public boolean add(E e) {
    ensureCapacity(size+1);
    elementData[size++] = e;
    return true;
  }
  //minCapacity:確保後に使いたい配列の分量
  private void ensureCapacity(int minCapacity) {
    minCapacity = max(DEFAULT_CAPACITY, minCapacity);
    if (minCapacity <= elementData.length) return;

    int oldCapacity = elementData.length;
    int newCapacity = oldCapacity +(oldCapacity >> 1);//1.5倍確保
    if (newCapacity < minCapacity) newCapacity = minCapacity;
    if (newCapacity > MAX_ARRAY_SIZE) throw new TooLargeArrayException("配列の大きさがいっぱい");
    elementData = Arrays.copyOf(elementData, newCapacity);
  }
  public void clear() {
    elementData = EMPTY;
    size = 0;
  }

  public E get(int index) {
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >= size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");
    return (E)elementData[index];
  }
  public E remove(int index) {
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >= size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");
    E tmp = (E)elementData[index];
    elementData[index] = null;
    return (E)tmp;
  }
  public E set(int index, E e) {
    E tmp = (E)elementData[index];
    elementData[index] = e;
    return tmp;
  }

  public int size() {
    return size;
  }

  public String toString() {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < size; i++) {
      if (elementData[i] == null) sb.append("null\t");
      else sb.append(elementData[i]+"\t");
    }
    return new String(sb);
  }
}

class TooLargeArrayException extends RuntimeException {
  public TooLargeArrayException(String msg) {
    super(msg);
  }
}
class ZeroArrayGetCellException extends RuntimeException {
  public ZeroArrayGetCellException(String msg) {
    super(msg);
  }
}*/
