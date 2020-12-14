import 'package:flutter/material.dart';

class AddQuestions extends StatefulWidget {
  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  TextEditingController _question = TextEditingController();
  TextEditingController _optionOneController = TextEditingController();
  TextEditingController _optionTwoController = TextEditingController();
  TextEditingController _optionThreeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Questions'),
      ),
      body: Form(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _question,
                  decoration: InputDecoration(hintText: 'Question'),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _optionOneController,
                  decoration:
                      InputDecoration(hintText: 'Options 1 (Correct Answer)'),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _optionTwoController,
                  decoration: InputDecoration(hintText: 'Options 2'),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _optionThreeController,
                  decoration: InputDecoration(hintText: 'Options 3'),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            //  fontSize: 20
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddQuestions(),
                        ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Add  Question',
                          style: TextStyle(
                            color: Colors.white,
                            //  fontSize: 20
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddQuestions(),
                        ));
                      },
                    ),
                  ),
                ],
              )
              // SizedBox(
              //   height: 6,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
