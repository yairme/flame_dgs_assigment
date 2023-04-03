// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart'; // Import the bloc package
import 'dart:async'; // Import the async package
import 'package:flame_dgs_assigment/bloc/flappy_bird_state.dart'; // Import the flappy bird state class

// Define an abstract class for Flappy Bird events
abstract class FlappyBirdEvent {}

// Define a ResetEvent class that extends FlappyBirdEvent
class ResetEvent extends FlappyBirdEvent {}

// Define a ScoreUpdateEvent class that extends FlappyBirdEvent
class ScoreUpdateEvent extends FlappyBirdEvent {
  final int score;

  ScoreUpdateEvent(this.score);
}

// Define a TimeUpdateEvent class that extends FlappyBirdEvent
class TimeUpdateEvent extends FlappyBirdEvent {
  final int remainingTime;

  TimeUpdateEvent(this.remainingTime);
}

// Define a StartGameEvent class that extends FlappyBirdEvent
class StartGameEvent extends FlappyBirdEvent {}

// Define the FlappyBirdBloc class, which extends the Bloc class
class FlappyBirdBloc extends Bloc<FlappyBirdEvent, FlappyBirdState> {
  Timer? _timer; // Declare a Timer variable

  // Create a FlappyBirdBloc object and pass it an initial FlappyBirdState object
  FlappyBirdBloc() : super(FlappyBirdState(0, 30, false)) {
    // Define what happens when a TimeUpdateEvent is dispatched
    on<TimeUpdateEvent>((event, emit) {
      if (event.remainingTime <= 0) {
        // If the remaining time is less than or equal to 0
        _timer?.cancel(); // Cancel the timer
        emit(state.copyWith(
            remainingTime: 0,
            isGameOver:
                true)); // Emit a new FlappyBirdState with isGameOver set to true
      } else {
        // Otherwise
        emit(state.copyWith(
            remainingTime: event
                .remainingTime)); // Emit a new FlappyBirdState with updated remaining time
      }
    });

    // Define what happens when a StartGameEvent is dispatched
    on<StartGameEvent>((event, emit) {
      emit(state.copyWith(
          score: 0,
          remainingTime: 30,
          isGameOver:
              false)); // Emit a new FlappyBirdState with score and remainingTime reset
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(TimeUpdateEvent(state.remainingTime -
            1)); // Set up a new timer to dispatch a TimeUpdateEvent
      });
    });

    // Define what happens when a ScoreUpdateEvent is dispatched
    on<ScoreUpdateEvent>((event, emit) {
      emit(state.copyWith(
          score: state.score +
              event.score)); // Emit a new FlappyBirdState with updated score
    });

    // Define what happens when a ResetEvent is dispatched
    on<ResetEvent>((event, emit) {
      _timer?.cancel(); // Cancels the timer if it's currently running
      emit(FlappyBirdState(0, 30,
          false)); // Emits a new FlappyBirdState with score=0, remainingTime=30, and isGameOver=false
    });
  }
}
