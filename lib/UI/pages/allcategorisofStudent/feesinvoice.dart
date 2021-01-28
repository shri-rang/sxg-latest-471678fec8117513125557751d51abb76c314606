import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/api/networkApi/networkapi.dart';
import 'package:simple_x_genius/model/feesInvoiceInfoModel.dart';
import 'package:simple_x_genius/api/networkApi/api_maneger.dart';

class FeesInvoice extends StatefulWidget {
  String id;

  FeesInvoice({this.id});

  @override
  _FeesInvoiceState createState() => _FeesInvoiceState();
}

class _FeesInvoiceState extends State<FeesInvoice> {
  // var ids = widget.id;

  Future<FeeModel> _feeModel;
  // var rest;
  // String ids;
  //  @override
  // void initState() {
  //    _feeModel = API_Manager().getFee(id);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    String id;
    id = widget.id;
    _feeModel = API_Manager().getFee(id);

    return Scaffold(
        appBar: AppBar(
          title: Text('Fees Invoice'),
        ),
        body: FutureBuilder<FeeModel>(
          future: _feeModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 15,
                  dataRowHeight: 40,

                  // headingTextStyle: TextStyle(
                  //   fontSize:20,

                  // ),
                  // var student = snapshot.data.sxg.studentdata[index];
                  columns: [
                    DataColumn(label: Text('Month')),
                    DataColumn(label: Text('Total\nAmount')),
                    DataColumn(label: Text('Paid\nAmount')),
                    DataColumn(label: Text('Due\nAmount')),
                    DataColumn(label: Text('Status\nAmount')),
                  ],
                  rows: snapshot.data.sxg.studentdata
                      .map((data) => DataRow(cells: [
                            DataCell(Text(data.month)),
                            DataCell(Text(data.amount)),
                            DataCell(Text(data.paidAmount)),
                            DataCell(Text(data.dueAmount)),
                            DataCell(Text(data.satus.toString())),
                          ]))
                      .toList(),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
