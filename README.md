# state-machine.js – trivial state machine

[![Build Status](https://secure.travis-ci.org/laurilehmijoki/state-machine.js.png)] (http://travis-ci.org/laurilehmijoki/state-machine.js)

## Usage

````javascript
var firstState = new StateMachine.State(
  function () {
    console.log('state entry')
  }, function () {
    console.log('state exit')
})

var secondState = new StateMachine.State(
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

## Build

    coffee --compile src

## Development

    npm install
    npm test

## License

Copyright Lauri Lehmijoki

MIT
