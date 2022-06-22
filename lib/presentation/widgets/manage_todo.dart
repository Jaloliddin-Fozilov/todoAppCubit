import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/todo/todo_cubit.dart';

class ManageTodo extends StatelessWidget {
  final Todo? todo;
  ManageTodo({
    this.todo,
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo == null) {
        context.read<TodoCubit>().addTodo(_title);
      } else {
        context.read<TodoCubit>().editTodo(todo!.id, _title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoEdited) {
          Navigator.of(context).pop();
        } else if (state is TodoError) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Error'),
              content: Text(
                state.message,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, enter title';
                    }
                    return null;
                  },
                  initialValue: todo == null ? '' : todo!.title,
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CLOSE'),
                    ),
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      child: Text(todo == null ? 'ADD' : 'EDIT'),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
