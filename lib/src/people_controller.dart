import 'dart:io';

import 'package:http_server/http_server.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PeopleController {
  HttpRequestBody requestBody;
  final HttpRequest request;
  final DbCollection dbCollection;

  PeopleController(this.requestBody, Db db)
      : request = requestBody.request,
        dbCollection = db.collection('people') {
    handle();
  }

  handle() async {
    switch (request.method) {
      case 'GET':
        await handleGet();
        break;
      case 'POST':
        await handlePost();
        break;
      case 'PUT':
        await handlePut();
        break;
      case 'DELETE':
        await handleDelete();
        break;
      case 'PATCH':
        await handlePatch();
        break;
      default:
        request.response.statusCode = 405;
    }
    await request.response.close();
  }

  handleGet() async {
    request.response.write(await dbCollection.find().toList());
  }

  handlePost() async {
    request.response.write(dbCollection.save(requestBody.body));
  }

  handlePut() async {
    var id = int.parse(request.uri.queryParameters['id']);
    var iteamtoput = await dbCollection.findOne(where.eq('id', id));
    if (iteamtoput == null) {
      await dbCollection.save(requestBody.body);
    } else {
      await dbCollection.update(iteamtoput, requestBody.body);
    }
  }

  handleDelete() async {
    var id = int.parse(request.uri.queryParameters['id']);
    var iteamtodelete = await dbCollection.findOne(where.eq('id', id));
    if (iteamtodelete != null) {
      await dbCollection.remove(iteamtodelete);
    }
  }

  handlePatch() async {
    var id = int.parse(request.uri.queryParameters['id']);
    var iteamtopatch = await dbCollection.findOne(where.eq('id', id));
    await dbCollection.update(iteamtopatch, {r'$set': requestBody.body});
  }
}
