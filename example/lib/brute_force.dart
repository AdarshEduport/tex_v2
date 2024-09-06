import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class BruteForceExample extends StatelessWidget {
  const BruteForceExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


      return const Placeholder();
  }
}


  class SequentialTeXViewRenderer extends StatefulWidget {
  const SequentialTeXViewRenderer({Key? key}) : super(key: key);

  @override
  _SequentialTeXViewRendererState createState() =>
      _SequentialTeXViewRendererState();
}

class _SequentialTeXViewRendererState extends State<SequentialTeXViewRenderer> {
  Queue<TeXView> teXViewQueue = Queue<TeXView>();
  TeXView? currentTeXView;

  @override
  void initState() {
    super.initState();
    // Initialize the first TeXView rendering
    if (teXViewQueue.isNotEmpty) {
      renderNextTeXView();
    }
  }

  // Method to enqueue a new TeXView widget
  void enqueueTeXView(TeXView teXView) {
    teXViewQueue.add(teXView);
    if (currentTeXView == null) {
      renderNextTeXView();
    }
  }

  // Method to render the next TeXView in the queue
  void renderNextTeXView() {
    if (teXViewQueue.isNotEmpty) {
      setState(() {
        currentTeXView = teXViewQueue.removeFirst();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentTeXView != null
        ? TeXView(
            key: UniqueKey(),
            loadingWidgetBuilder: (context) {
              return const CircularProgressIndicator();
            },
            onRenderFinished: (height) {
              // After the current TeXView finishes rendering, render the next one
              renderNextTeXView();
            },
            child: currentTeXView!.child,
          )
        : Container(); // Return an empty container if no TeXView to render
  }
}