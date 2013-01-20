class State
  constructor: (@entryAction, @exitAction) ->

class CyclicStateMachine
  constructor: (@states) ->

  start: (startArgument) =>
    @currentStateIndex = 0
    @isStarted = true
    @currentState().entryAction(startArgument)
    this

  currentState: =>
    unless @isStarted
      throw 'State machine not started. Invoke #start first.'
    @states[@currentStateIndex]

  transition: (transitionArgument) =>
    oldState = @currentState()
    @currentStateIndex = @nextStateIndex()
    oldState.exitAction(transitionArgument)
    @currentState().entryAction(transitionArgument)
    this

  nextStateIndex: =>
    if @currentStateIndex == @states.length - 1
      0
    else
      @currentStateIndex + 1

StateMachine = @StateMachine = {}
StateMachine.State = State
StateMachine.CyclicStateMachine = CyclicStateMachine
