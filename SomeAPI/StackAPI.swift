//
//  StackAPI.swift
//  SomeAPI
//
//  Created by Takamiya Kengo on 2021/03/15.
//

import Foundation

public final class Stack<E> : Sequence {
  private var first: Node<E>? = nil
  
  private(set) var count: Int = 0
  
  fileprivate class Node<E> {
    fileprivate var item: E
    fileprivate var prev: Node<E>?
    fileprivate var next: Node<E>?
    fileprivate init(item: E, prev: Node<E>? = nil,next: Node<E>? = nil) {
      self.item = item
      self.prev = prev
      self.next = next
    }
  }
  
  public init() {}
  
  public func isEmpty() -> Bool {
    return first == nil
  }
  
  public func push(item: E) {
    let oldFirst = first
    first = Node<E>(item: item, prev: nil,next: oldFirst)
    oldFirst?.prev = first
    count += 1
  }
  
  public func pop() -> E?{
    if first?.next != nil {
      let newfirst = first?.next
      newfirst?.prev = nil
      let removeFirst = first
      first = newfirst
      count -= 1
      return removeFirst?.item
    } else if first != nil{
      let removeFirst = first
      first = nil
      count -= 1
      return removeFirst?.item
    } else {
      count -= 1
      return nil
    }
  }
  
  public func peek() -> E?{
    if first != nil{
      return first!.item
    } else {
      return nil
    }
  }
  
  public struct StackIterator<E> : IteratorProtocol {
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
  
  public func makeIterator() -> StackIterator<E> {
    return StackIterator<E>(first)
  }
}


