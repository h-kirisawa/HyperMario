import java.util.AbstractList;
import java.util.AbstractSequentialList;
import java.util.Arrays;
import java.util.List;
import java.util.Iterator;
import java.util.ListIterator;


class MyList2<E> extends AbstractList<E> {
  private Cell<E>[] elementData;
  private final int DEFAULT_CAPACITY = 10;
  private final int MAX_ARRAY_SIZE = 1000000;

  private Cell<E> first;
  private Cell<E> last;
  private int size;

  public MyList2() {
    elementData = new Cell[DEFAULT_CAPACITY];
    this.size = 0;
  }
  public MyList2(int size) {
    elementData = new Cell[size];
    this.size = 0;
  }

  //nullデータをリストにすることは考慮しない
  @Override
    public boolean add(E e) {    
    ensureCapacity(size+1);
    if (e == null) {
      size++;
      return true;
    }

    Cell<E> c = new Cell(e);
    if (first == null) {
      first = last = c;
      c.next = c.prev = null;
    } else {
      c.next = null;
      c.prev = last;
      last.next = c;
      last = c;
    }

    elementData[size++] = c;
    return true;
  }
  //minCapacity:確保後に使いたい配列の分量
  private void ensureCapacity(int minCapacity) {
    //minCapacity = max(DEFAULT_CAPACITY, minCapacity);
    if (minCapacity <= elementData.length) return;

    int oldCapacity = elementData.length;
    int newCapacity = oldCapacity +(oldCapacity >> 1);//1.5倍確保
    if (newCapacity < minCapacity) newCapacity = minCapacity;
    if (newCapacity > MAX_ARRAY_SIZE) throw new TooLargeArrayException("配列の大きさがいっぱい");
    elementData = Arrays.copyOf(elementData, newCapacity);
  }

  @Override
    public void clear() {
    size = 0;
    elementData = new Cell[DEFAULT_CAPACITY];
    first = last = null;
  }

  @Override
    E get(int index) {
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >= size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");

    if (elementData[index] == null) return null;
    return (E)elementData[index].data;
  }

  //配列番号index以下にある最後のcellをとってくる
  private Cell<E> getCell(int index) { 
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >=  size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");

    int i;
    for (i = index; i > 0; i--) {
      if (elementData[i] != null) break;
    }
    //[0]にあればおｋ、nullでもnull値返しおｋ
    return elementData[i];
  }

  @Override
    public Iterator<E> iterator() {
    return new ArrayIterator();
  }

  @Override
    //@SuppressWarnings("unused")
    public E remove(int index) {
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >= size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");

    Cell<E> tmp = elementData[index];
    if (tmp == null) return null;

    elementData[index] = null;
    if (tmp == first) {
      first = tmp.next;
      first.prev = null;
    } else if (tmp == last) {
      last = tmp.prev;
      last.next = null;
    } else {
      tmp.prev.next = tmp.next;
      tmp.next.prev = tmp.prev;
    }
    return (E)tmp.data;
  }
  @Override
    int size() {
    return size;
  }

  @Override
    E set(int index, E e) {
    if (index < 0) throw new IndexOutOfBoundsException("負の値はないって m9(^Д^)ﾌﾟｷﾞｬｰ");
    if (index >= size) throw new IndexOutOfBoundsException("卍そんなでかいindex存在しません卍");

    if (e == null) return remove(index);

    Cell<E> cell = getCell(index);
    Cell<E> tmp = elementData[index];
    if (tmp == null) {
      tmp = elementData[index] = new Cell(e);
      if (cell == null) {
        tmp.next = first;
        tmp.prev = null;
        first.prev = tmp;
        first = tmp;
      } else if(cell == last){
        tmp.next = null;
        tmp.prev = last;
        last.next = tmp;
        last = tmp;
      } else {
        cell.next.prev = tmp;
        tmp.next = cell.next;
        cell.next = tmp;
        tmp.prev = cell;
      }
      return null;
    } else {
      tmp = elementData[index] = new Cell(e);
      if (cell == last) {
        tmp.next = null;
        tmp.prev = cell.prev;
        tmp.prev.next = tmp;
        last = tmp;
      } else if (cell == first) {
        tmp.next = cell.next;
        tmp.next.prev = tmp;
        tmp.prev = null;
        first = tmp;
      } else {
        tmp.next = cell.next;
        tmp.next.prev = tmp;
        tmp.prev = cell.prev;
        tmp.prev.next = tmp;
      }
      return cell.data;
    }
  }
  
  public E setOver(int index, E e){
    ensureCapacity(index + 1);
    if(size <= index) size = index+1;
    return set(index, e);
  }

  //test
  public String toString() {
    String str = "";
    for (int i = 0; i < size; i++) {
      if (elementData[i] == null) {
        str = str +"null, ";
      } else {
        str = str +elementData[i].data + ", ";
      }
    }
    return str;
  }

  private class Cell<T> {
    T data;
    Cell<T> next;
    Cell<T> prev;

    public Cell(T data) {
      this.data = data;
    }

    String toString() {
      return ""+data;
    }
  }


  //Iteratorインターフェースを継承した「何か」を作ればよい
  private class ArrayIterator<I> implements Iterator<I> {
    Cell<I> next;

    public ArrayIterator() {
      next = (Cell<I>)first;
    }

    public boolean hasNext() {
      return next != null;
    }
    public I next() {
      Cell<I> tmp = next;
      next = next.next;
      return (I)tmp.data;
    }
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
}
