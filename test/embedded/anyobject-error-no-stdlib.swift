// RUN: %target-swift-emit-ir -parse-stdlib %s -enable-experimental-feature Embedded -verify -wmo

public enum Never {}

@_silgen_name("abort")
func abort() -> Never

@_semantics("typechecker.type(of:)")
public func type<T, Metatype>(of value: T) -> Metatype { abort() }

public typealias AnyObject = Builtin.AnyObject

precedencegroup AssignmentPrecedence { assignment: true }

public func foo(_ x: AnyObject) {
  _ = type(of: x) // expected-error {{using values of protocol type 'AnyObject' is not allowed in embedded Swift}}
  // expected-note@-1 {{called from here}}
}
