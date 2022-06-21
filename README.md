# iOS16

Swift Generics

- Generics are here to abstract away the details of a specific type
- if you find yourself writing overloads with repetitive implementations, it might be a sign to that you need to generalize
- Start with concrete types, generalize when needed

Polymorphism

- ability of abstract code to behave differently for different concrete types
- allows one piece of code to have many behaviors depending on how the code is used
- The different forms of polymorphism:


ad-hoc polymorphism: 
- the same function call can mean different things depending on the argument type
- Swift function overloading


subtype polymorphism:
- code operating on a supertype can have different behavior based on the specific subtype the code is using at runtime
- Subclassing in Swift, where a class overrides a method of their superclass


parametric polymorphism:
- achieved using generics
- Generic code uses type parameters to allow writing one piece of code that works with different types, and concrete types themselves are used as arguments


