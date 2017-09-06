//
//  DynamicBinder.swift
//  Pods
//
//  Created by Vasilii Muravev on 29/08/2017.
//
//

// MARK: - Typealias
typealias BindedHandler<T> = (T) -> Void

struct DynamicBinderInterface<T> {
  
  // MARK: - Public Instance Attributes
  var value: T { return binder.value }
  
  
  // MARK: - Private Instance Attributes
  private unowned let binder: DynamicBinder<T>
  
  
  // MARK: - Initializers
  fileprivate init(_ binder: DynamicBinder<T>) {
    self.binder = binder
  }
  
  
  // MARK: - Public Instance Methods
  func bind(with observer: AnyObject, _ handler: BindedHandler<T>?) {
    binder.bind(with: observer, handler)
  }
  
  func bindAndFire(with observer: AnyObject, _ handler: BindedHandler<T>?) {
    binder.bindAndFire(with: observer, handler)
  }
  
  func unbind(_ observer: AnyObject) {
    binder.unbind(observer)
  }
}

class DynamicBinder<T> {
  
  // MARK: - Public Instance Attributes
  lazy var interface: DynamicBinderInterface<T> = { [unowned self] in
    return DynamicBinderInterface(self)
    }()
  var value: T { didSet { fireListeners() }}
  
  
  // MARK: - Private Instance Attributes
  private var listeners: [Listener<T>] = []
  
  
  // MARK: - Initializers
  init(_ value: T) {
    self.value = value
  }
  
  @available(*, unavailable) private init() {
    fatalError("unavailable")
  }
  
  
  // MARK: - Public Instance Methods
  func fire() {
    fireListeners()
  }
  
  
  // MARK: - Private Instance Methods
  fileprivate func bind(with observer: AnyObject, _ handler: BindedHandler<T>?) {
    let listener = Listener(observer, handler)
    listeners.append(listener)
  }
  
  fileprivate func bindAndFire(with observer: AnyObject, _ handler: BindedHandler<T>?) {
    bind(with: observer, handler)
    handler?(value)
  }
  
  fileprivate func unbind(_ observer: AnyObject) {
    listeners = listeners.filter({
      guard let observerInArray = $0.observer else { return false }
      return observer !== observerInArray
    })
  }
  
  /// Fires all listeners and cleans deallocated observers.
  private func fireListeners() {
    listeners = listeners.flatMap({
      guard let handler = $0.handler, $0.observer != nil else {
        return nil
      }
      handler(value)
      return $0
    })
  }
}


// MARK: - Listener
private struct Listener<T> {
  weak var observer: AnyObject?
  var handler: BindedHandler<T>?
  init(_ observer: AnyObject, _ handler: BindedHandler<T>?) {
    self.observer = observer
    self.handler = handler
  }
}
