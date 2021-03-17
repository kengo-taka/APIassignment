//
//  Queue.swift
//  SomeAPI
//
//  Created by Takamiya Kengo on 2021/03/16.
//
import Foundation

public final class Queue<E> : Sequence {
  private var first: Node<E>? = nil
  private var last: Node<E>? = nil
  
  private(set) var count: Int = 0
  
  fileprivate class Node<E> {
    fileprivate var item: E
    fileprivate var prev: Node<E>?
    fileprivate var next: Node<E>?
//    fileprivate var markLast: Int?
//    fileprivate init(item: E, prev: Node<E>? = nil,next: Node<E>? = nil, markLast : Int? = nil) {
    fileprivate init(item: E, prev: Node<E>? = nil,next: Node<E>? = nil) {

      self.item = item
      self.prev = prev
      self.next = next
//      self.markLast = markLast
    }
  }
  
  public init() {}
  
  public func isEmpty() -> Bool {
    return first == nil
  }
  
  public func enqueue(item: E) {
    if first != nil {
      let oldFirst = first
      first = Node<E>(item: item, prev: nil,next: oldFirst)
      oldFirst?.prev = first
      count += 1
    } else  {
      first = Node<E>(item: item, prev: nil,next: nil)
      last = first
      count += 1
  }
  }
  
  public func dequeue() -> E?{
    if count >= 2 {
      let removeItem = last
      last?.prev = last
      count -= 1
      return removeItem?.item
    } else if count == 1 {
      let removeFirst = first
      first = nil
      last = nil
      count -= 1
      return removeFirst?.item
    } else {
      return nil
    }
  }
  
  public func peek() -> E?{
    if first != nil{
      return last?.item
    } else {
      return nil
    }
  }
  
  public struct QueueIterator<E> : IteratorProtocol {
    public typealias Element = E
    
    private var current: Node<E>?
    
    fileprivate init(_ first: Node<E>?) {
      self.current = first
    }
    
    public mutating func next() -> E? {
      if let item = current?.item {
        current = current?.next
        return item
      }
      return nil
    }
  }
  
  public func makeIterator() -> QueueIterator<E> {
    return QueueIterator<E>(first)
  }
}


