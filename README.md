# state-machine.js – trivial state machine in JavaScript

## Usage

````javascript
var firstState = new StateMachine.State(
  "publishing in progress",
  function () {
    console.log('state entry')
  }, function () {
    console.log('state exit')
})

var secondState = new StateMachine.State(
  "publishing completed",
  function () {
    console.log('state entry')
  }, function () {
    console.log('state exit')
})

var publishStateMachine = new StateMachine.CyclicStateMachine([firstState, secondState])
publishStateMachine.start() // Go to state 1
publishStateMachine.transition() // Go to state 2
publishStateMachine.transition() // Start from beginning; go to state 1
````

## Development

    npm install
    npm test
