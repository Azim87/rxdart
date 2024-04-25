import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = useMemoized(
      () => BehaviorSubject<String>(),
      [key],
    );

    useEffect(
      () => subject.close,
      [subject],
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: StreamBuilder<String>(
            stream: subject.stream.distinct().debounceTime(const Duration(seconds: 1)),
            initialData: 'Please start typing',
            builder: (ctx, snapshot) {
              return Text(snapshot.requireData);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: subject.sink.add,
        ),
      ),
    );
  }
}
