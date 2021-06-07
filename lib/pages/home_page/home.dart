import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/pages/result_page/result.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(tr('home'))),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              TextFormField(
                controller: _controller,
                validator: (str) {
                  if (str!.isNotEmpty) {
                    return null;
                  } else
                    return tr('err');
                },
                decoration: InputDecoration(
                    labelText: tr('hint'),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5),
              MaterialButton(
                  color: Theme.of(context).primaryColor,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              Result(name: _controller.text.trim())));
                    }
                  },
                  child: Text(
                    tr('search'),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
