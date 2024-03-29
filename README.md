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
- the compiler can convert an instance of any X to some x by unboxing the underlying value and passing it directly to the some X parameter
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

### Deprecation notice
- All previous navigation APIs are deprecated:
- NavigationView is replaced by two new containers, NavigationStack and NavigationSplitView (more on this later)
- NavigationLink still exists, has a completely different API and behavior, and is no longer mandatory to use

### New navigation APIs
#### Containers

- with the new containers, we have a single binding for managing their stack state/path
- this single binding represents all the values pushed onto the stack, think of it as an array of screens
- The new NavigationLink APIs append values to this binding
- you can directly mutate this binding yourself (just add/remove elements from this state/path array)
- You can programmatically push/pop multiple screens at once
- You can programmatically deep link
- You can pop to the root view by removing all the items

Two new containers:

- NavigationStack - for a single push-pop stack
- NavigationSplitView - for multi-column apps
- automatically adapts into a single-column stack on iPhone, into Slide Over on iPad, Apple Watch and Apple TV
- provides configuration options that let you:
- customize column widths (see navigationSplitViewColumnWidth(_:) and similar modifiers)
- control sidebar presentation and show/hide columns (see NavigationSplitViewVisibility and associated modifiers)


NavigationSplitView has two initializers:

- To create a two-column navigation split view, use init(sidebar:detail:)
- To create a three-column view, use the init(sidebar:content:detail:)

NavigationLink

- appends elements onto the stack it appears in
- no longer accepts a destination parameter (we use the new navigationDestination(for:destination:) modifier instead)
is no longer needed, programmatically append things to the $path state yourself instead
- navigationDestination(for:destination:) modifier
- declares the type of the presented data that it's responsible for
- takes in a view builder that describes what view to push onto the stack when a instance of that data is presented
- Every navigation stack keeps track of a path that represents all the data that the stack is showing
- When the stack shows its root view, the path is empty
- the stack also keeps track of all the navigation destinations declared inside it, or inside any view pushed onto the stack
- if you'd like to use this path yourself (e.g., for programmatic navigation), use the new type-erasing NavigationPath collection where you can push values of different types

Persistent state

- encapsulate your navigation state into a Codable model
- use SceneStorage to save and restore that state
- restore data via .task:

## Single App Mode (SAM

### What is a Single App Mode (SAM)?
- Restrict certain behaviors on iOS / iPadOS
- Lock device to single app
- Initiated by system or app
- Allow control of timing between restricted and unrestricted state
- Can also apply restrictions on top of single app mode (such as enabling/disabling auto-lock)

### When do you use a Single App Mode?
3 examples when you'd want a device in SAM: 
- iPad used to place food orders at an event 
- Device used in medical setting where patients are passed device from staff to fill out info 
- Device used in school environment for students taking tests
- 
#### Another use case: Guided Access. Any user can put any app in Single App Mode

### Guided Access
Allows device user to put any app in Single App Mode, i.e. is user-initiated.

### Developer considerations


#### UIAccessibility API Custom Restrictions
- Tailor experience in GAX by restriction parts of your app's functionality
- Accommodate those with cognitive or learning disabilities, who might need a different experience within your app


### Design principles for cognitive AX
- Be forgiving of errors and mitigate them before they happen
- Warm users before performing irreversible actions (like deleting a thread)
- Reduce dependence on timing; using timed alerts, automatically performing an action after a timeout are an anti-pattern to avoid
- Always confirm payments


## Single App Modes

- All other SAMs enter SAM programmatically, not initiated by the user like Guided Access.
- Prevent users from swiping home, modifying settings, looking things up in safari etc.


### (Basic) Single App Mode
- Good when you want to stay in single app forever on this device, i.e. kiosk food ordering scenario
- Stay locked in app even after reboot
- No manual intervention for upkeep of this mode
- Device must be supervised via Apple Configurator (or other device management software)
- This software can put many devices in SAM at one time
- In Apple Configurator: select a device -> Advanced -> Start Single App Mode -> Select App to lock into

### Autonomous Single App Mode (ASAM)
- Good when restricted state needs to be entered and exited, i.e. medical scenario where we'd enter this mode when passing device to patient and exit when they return it to us
- App makes API method call to get in and out of Single App Mode
- Must ALSO be supervised via Apple Configurator (or other device management software)
- App must also be allow-listed for ASAM in device's configuration profile
- On failure, we might want to alert user in completion handler that we failed to lock down the app so they don't hand the device to the patient
- Status change callbacks can invoke behaviors as you enter/exit ASAM mode


### Assessment Mode
- Restrict certain features like spell check during testing to avoid unfair advantages
- Test takers also cannot access outside notes/resources, etc.
- Unified API macOS / iOS
- Does not require supervision (i.e. Apple Configurator)
- But must apply to Apple for an assessment entitlement
- Check out What's new in assessment for more info

### Accessibility API
- People using assistive technologies like VoiceOver or Switch Control may also use apps in Single App Modes
Example: someone who is blind comes to order food on your kiosk app. How do they turn on VoiceOver?
- Apple Configurator and other device management software let you configure accessibility options for SAMs
- Accessibility shortcut is configurable to show a subset of iOS accessibility features
- Some accessibility features can also be set to always enabled
- This enables people who rely on these technologies to continue using them on them while using your app
- These options must be configured before entering a SAM
- You can also toggle features directly with code (i.e. while in a SAM)
- Good for kiosk enclosure where hardware buttons are blocked, so Accessibility Shortcut is not available
- API for turning off/on certain Accessibility features: Zoom , VO, Invert Colors, AST, Gray-scale
