# iOS16 WWDC 22

## Swift Generics



- Generics are here to abstract away the details of a specific type
- if you find yourself writing overloads with repetitive implementations, it might be a sign to that you need to generalize
- Start with concrete types, generalize when needed

## Polymorphism


- ability of abstract code to behave differently for different concrete types
- allows one piece of code to have many behaviors depending on how the code is used
- The different forms of polymorphism:



 ### ad-hoc polymorphism: 
- the same function call can mean different things depending on the argument type
- Swift function overloading


 ### subtype polymorphism:
- code operating on a supertype can have different behavior based on the specific subtype the code is using at runtime
- Subclassing in Swift, where a class overrides a method of their superclass



 ### parametric polymorphism:
- achieved using generics
- Generic code uses type parameters to allow writing one piece of code that works with different types, and concrete types themselves are used as arguments

## protocol 

- interface that represents capabilities
- separates ideas from implementation details
- abstraction tool that describes the functionality of conforming types
- separates ideas from implementation details
- each capability maps to a protocol requirement
- the name of the protocol should represent the category of types we're describing


### associatedtype:
- serves as a placeholder for a concrete type
- associated types depend on the specific type that conforms to the protocol


### Opaque type vs. underlying type

- Opaque type - abstract type that represents a placeholder for a specific concrete type
- underlying type - specific concrete type that is substituted in the opaque type
- For values with opaque type, the underlying type is fixed for the scope of the value
- generic code using the value is guaranteed to get the same underlying type each time the value is accessed
- opaque type can be used both for inputs and outputs


### some:

- we can express an abstract type in terms of the protocol conformance by writing some xxx
- all three declarations above are identical, but the newer one is much easier to read and understand
- the some keyword can be used in parameter and result types
- with some, there is a specific underlying type that cannot vary


### any:

- if we need to express an arbitrary type a protocol, for example to store multiple into an array, we can use any
- with any, the underlying type can vary at runtime
- any xxx is a single static type that has the capability to store any concrete X-conforming type dynamically, which allows us to use subtype polymorphism with value types
- to allow for any required flexible storage, the any X type has a special representation in memory

you can think of this representation as a fixed box:
- if the concrete type can fit within the box, it will be stored there
- the box will store a pointer to the instance otherwise
- the static type any X that can dynamically store any concrete X type is called an existential type
- the strategy of using the same representation for different concrete types is called type erasure
- the concrete type is said to be erased at compile time, and the concrete type is only known at runtime


#### some vs. any


-the compiler can convert an instance of any X to some x by unboxing the underlying value and passing it directly to the some X parameter
- use some by default
- change to any when you need to store arbitrary values (arbitrary concrete types instances)


#### some	                            
- holds a fixed concrete type     	
- guarantees type relationships   	

#### any
- holds an arbitrary concrete type
- erases type relationships


### Type erasure: 

eliminates the type-level distinction between different X-conforming instances, which allows us to use values with different dynamic types interchangeably as the same static type.

- when you call a method returning an associated type on an existential type, the compiler will use
- type erasure to determine the result type of the call
type erasure replaces these associated types with corresponding existential types that have equivalent constraints

### Type erasure semantics

- Producing position: associatedtypes appearing in the result of a protocol method declaration are in producing position
- The type any xxx is called the upper bound of the associated CommodityType
- the actual concrete type that is returned from xxxx() can safely convert to the upper bound
- type erasure does not allow us to work with associated types in consuming position instead, you must unbox the existential any type by passing it to a function that takes an opaque some type

### Identify type relationships

- every protocol has a Self type, which stands for the concrete conforming type
- we can express the relationship between associatedtypes using a same-type requirement, written in a where clause
- A same-type requirement expresses a static guarantee that two different, possibly nested associated types must in fact be the same concrete type
- By understanding your data model, you can use same-type requirements to define equivalences between these different nested associated types
- Generic code can then rely on these relationships when chaining together multiple calls to protocol requirements

## distributed actors




## Swift Actors
- designed to protect you from low-level data races in the same process
- compile-time enforced actor isolation checks

## Distributed actors
- an extension of Swift’s actor model that simplifies development of distributed systems. 
- designed to protect you from low-level data races across multiple processes eg. communication among multiple devices or servers in a cluster
- By using distributed actors, we're able to establish a channel between two processes and send messages between them
- Distributed actors still isolate their state and still can only communicate using asynchronous messages
- It's ok to have multiple distributed actors in the same process
- Distributed actors are just actors, but can participate in remote interactions whenever necessary
- Distributed actors always belong to some distributed actor system, which handles all the serialization and networking necessary to perform remote calls 
- Every distributed actor is assigned an id, uniquely identify said actor in the entire distributed actor system that it is part of.
- ids are assigned by the distributed actor system as the actor is initialized, and later managed by that system (we cannot declare or assign the id property manually)

#### Location transparency: 
- ability to be potentially remote without having to change how we interact with such distributed actor
- regardless where a distributed actor is located, we can interact with it the same way
- allows us to transparently move our actors, without having to change their implementation

## Road to distributed actors
- Pick a local actor that you'd like to move to distribute actor
- Turn it into a (still local) distributed actor
- Move the distributed actor ActorSystem to be remote
- Setup server side app

# SwiftUI

## Swift Charts 

- Chart is the main outside wrapper 
- BarMark with x and y positions and .value data
- first argument of value is description, second the value
- make data types Identifiable to use in Charts
- supports ForEach for Identifiable data collections
- Implicit forEach via a Chart initializer taking a data collection
- Charts chooses an appropriate visualization automatically
- Adapts to dynamic type, device sizes, orientations, dark mode and supports accessibility automatically
- .value also accepts a unit for types like Date, e.g. .day
- Supports SwiftUI animations (e.g. animate between different data collections but same bar chart view)
- Use .foregroundStyle(by: to group data by color → auto-generated legend for the colors
- Easy to change from BarMark to PointMark or LineMark (great for prototyping charts!)
- Also .symbol(by: a value available to use square/circle instead of color to differentiate data form each other 
- Marks: Bar, Point, Line
- Mark Properties: X Position, Y Position, Foreground Style, Symbol
- More Marks available: Area, Rule, Rectangle
- More Mark Properties available: Symbol Size, Line Style
- Marks and composition: a Mark is a graphical element that represents data
- Chart is a SwiftUI view used as the wrapper for charts
- Provide multiple BarMark views to show multiple bars

## Navigation


