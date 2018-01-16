//
//  main.swift
//  Linked list with head and tail pointers
//
//  Created by Natalia on 11/10/2017.
//  Copyright © 2017 Natalia. All rights reserved.
//



// Edge cases:
// linked list of 0, 1, 2 length
// inserting after last element (need to move tail pointer)
// deleting first element (move head pointer)
// deleting last element (need to move head or tail pointers)


import Foundation

class LinkedList {
    var headElement: Element?
    var tailElement: Element?
    
    init () {
        headElement = nil
        tailElement = nil
    }
    
    // linked list with delete(x) and insertAfter(afterY, x data) functions
    class Element {
        var data : Int
        var next : Element?
        
        init (data: Int, next: Element?) {
            self.data = data
            self.next = next
        }
    }
    
    func insertAfter(_ data: Int, after: Int) -> Bool {
        
        // if there is no current head (empty list) create and link to head AND tail pointers
        if (self.headElement == nil) {
            self.headElement = Element(data: data, next: nil)
            self.tailElement = headElement
            return true
        }
            // if match is head element but there is no next, insert after and link next to nil, and also link to tail pointer.
            // IF there IS another element after, the insert and link to this next item
            
        else if (self.headElement!.data == after) {
            if headElement?.next == nil {
                headElement?.next = Element(data: data, next: nil)
                tailElement = headElement?.next
                return true
            } else {  // if head.next is not nil, then create and link up to the current next
                headElement!.next = Element(data: data, next: headElement?.next)
                return true
            }
        }
            
        // else if after matches the tail element, insert and link to tail pointer
        else if (self.tailElement?.data == after) {
            tailElement?.next = Element(data: data, next: nil)
            tailElement = tailElement!.next
            return true
        }
            
        // else if its not going after a head or a tail, or into an empty list, cycle through list til find match, then insert after match and link up
        else {
            var tempElement: Element = headElement!
            while (tempElement.next != nil) && (tempElement.next?.data != after) {
                tempElement = tempElement.next!
            }
            // if exits loop make sure its not b/c reached the end of the list, if so add item
            if (tempElement.next != nil) {
                tempElement.next = Element(data: data, next: tempElement.next)
                return true
            } else {
                print("error \(after) not found to insert after")
                return false
            }
        }
    }
    
    // basic add an element at end of list then link up
    func add(_ data: Int) {
        if headElement == nil {
            headElement = Element(data: data, next: nil)
            tailElement = headElement
        } else {
            var tempElement: Element = headElement!
            while (tempElement.next != nil) {
                tempElement = tempElement.next!
            }
            tempElement.next = Element(data: data, next: nil)
            tailElement = tempElement.next
        }
    }
    
    
    func remove(_ data: Int) -> Bool {
        // if the head is the Int to remove, remove and then link up 2nd element to head pointer
        
        if (headElement == nil) {
            print("error empty list")
            return false
        }
        else if (headElement?.data == data) {
            headElement = headElement?.next
            return true
        } else if (headElement!.next == nil) {
            print("error \(data) not found. list only had one item")
            return false
        }
        // if Int is not at head, cycle through list looking for element. keep track of the current element. if found remove and link up. If the current.next = tail, check current and tail for match w int, if no match return false
        else {
            var currentElement: Element? = headElement!.next
            if (currentElement?.data == data) {
                headElement?.next = currentElement?.next
                return true
            } else {
                while (currentElement?.next!.next != nil) {  // ie while current is not the 2nd last - curr.next = tail in that case
                    if (currentElement?.next!.data == data) {
                        currentElement?.next = currentElement?.next!.next
                        return true
                    } else {
                        currentElement? = currentElement!.next!
                    }
                }
                // if next is the tail
                if (tailElement!.data == data) {
                    currentElement?.next = nil
                    tailElement = currentElement
                    return true
                } else {
                    print("error: \(data) not found for removal")
                    return false
                }
            }
        }
    }
    
    func fillFromList(_ int_array: [Int])  {
        for item in int_array {
            self.add(item)
        }
    }
    
    func removeHead() {
        if headElement == nil { print("error no head to remove")
        }
        else {
            headElement = headElement?.next
        }
    }
    
    func printAllElements() {
        if (headElement == nil) {
            print("no elements in list")
        }
        else {
            print("list contains: \(headElement!.data)", " ", terminator: "")
            
            var tempElement: Element = headElement!
            while (tempElement.next != nil) {
                tempElement = tempElement.next!
                print(tempElement.data, " ", terminator: "")
            }
            print("")
        }
    }
    
    // function that finds the nth element from the end of the list.
    // it traverses the list until n elements deep into the list (without reaching the end where next==nil).
    func nthListElement(_ n: Int) -> Int? {

        if (self.headElement == nil) {
            print("\(#function) error,  no elements in list")
            return nil
        }
        var distanceIntoList: Int = 1
        var currentElement: Element = headElement!
        
        while (distanceIntoList != n) {
            if (currentElement.next == nil) {
                print("End of list reached before \(n) elements deep, returning nil.")
                return nil
            } else {
                //print("distance in: \(distanceIntoList), currentElm is \(currentElement.data)")
                currentElement = currentElement.next!
                distanceIntoList += 1
            }
        }
        // we know we reached the mth element without the list ending...so now we increment while tracking mth element
        
        var nthElement: Element? = headElement
        //print("left first while loop. curElm is \(currentElement.data), distance in is \(distanceIntoList), mth is \(mthElement!.data)")
        
        while (currentElement.next != nil) {
            currentElement = currentElement.next!
            nthElement = nthElement?.next
        }
        print("\(#function) returning '\(n)'th element = \(nthElement!.data)")
        return nthElement!.data
    }
}



func testLists () {
    
    // empty list
    print("List 1: should be an empty list")
    
    let emptylist = LinkedList()
    emptylist.add(5)
    emptylist.printAllElements()
    emptylist.removeHead()
    emptylist.remove(5)
    emptylist.removeHead()
    
    print("\n")
    print("List 2")

    // single item list - head and tail are the same
    let list1 = LinkedList()
    let list1_inital_items = [1]
    list1.fillFromList(list1_inital_items)
    
    list1.insertAfter(2, after: 1)
    list1.insertAfter(4, after: 5)
    list1.printAllElements()
    
    print("\n")
    print("List 2")
    
    // list with two items
    let list2 = LinkedList()
    let list2_inital_items = [1, 2, 3, 4, 5, 6]
    
    list2.fillFromList(list2_inital_items)
    
    list2.nthListElement(4)
    list2.nthListElement(1)
    list2.nthListElement(6)
    
    print("\n")
    print("List3")
    
    let list3 = LinkedList()
    list3.add(1)
    list3.add(2)
    list3.add(3)
    list3.add(4)
    list3.add(5)
    list3.printAllElements()
    
    print("Remove 1, 5, 6, insert 1 after 2, 2 after 1, and 3 after 2")
    list3.remove(1)
    list3.remove(5)
    list3.remove(6)
    list3.insertAfter(1, after: 2)
    list3.insertAfter(2, after: 1)
    list3.insertAfter(3, after: 2)
    
    print("\n")
    print("List3 now:")
    list3.printAllElements()
}

testLists()


