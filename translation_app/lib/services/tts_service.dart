
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsService {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  void Function()? startHandler;
  void Function()? initHandler;
  void Function()? completionHandler;
  void Function()? cancelHandler;
  void Function()? pauseHandler;
  void Function()? continueHandler;
  void Function()? errorHandler;

  TtsService({this.ttsState = TtsState.stopped,
    this.startHandler,
    this.initHandler,
    this.completionHandler,
    this.cancelHandler,
    this.pauseHandler,
    this.continueHandler,
    this.errorHandler
  }) {
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    setAwaitOptions();

    if (isAndroid) {
      getDefaultEngine();
      getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      startHandler!();
      ttsState = TtsState.playing;
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        initHandler!();
      });
    }

    flutterTts.setCompletionHandler(() {
      completionHandler!();
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      cancelHandler!();
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      pauseHandler!();
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      continueHandler!();
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      errorHandler!();
      ttsState = TtsState.stopped;
    });
  }

  Future<dynamic> getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> getEngines() async => await flutterTts.getEngines;

  getDefaultEngine() async {
    return await flutterTts.getDefaultEngine;
  }

  getDefaultVoice() async {
    return await flutterTts.getDefaultVoice;
  }

  speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  stop() async {
    return await flutterTts.stop();
  }

  pause() async {
    return await flutterTts.pause();
  }
}