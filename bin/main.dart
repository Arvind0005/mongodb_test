import 'dart:convert';
import 'package:dart_mongo/dart_mongo.dart' as dart_mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
import 'package:http_server/http_server.dart';

main(List<String> arguments) async {
  int port = 500;
  var server = await HttpServer.bind('localhost', port);
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();
  print("connected");
  // await db.close();
  // await server.close();

  DbCollection coll = db.collection('people');
  var people = await coll.find().toList();
  //print(people);
  // await db.close();
  // await server.close();
  server
      .transform(dart_mongo.HttpBodyHandler())
      .listen((HttpRequestBody reqbody) async {
    // if (request.uri.path == '/') {
    //   request.response.write('hello world');
    //   //await request.response.close();
    //   // await db.close();
    //   // await server.close();
    // } else if (request.uri.path == '/people') {
    //   request.response.write(await coll.find().toList());
    //   //await request.response.close();
    //   // await db.close();
    //   // await server.close();
    // }
    switch (reqbody.request.uri.path) {
      case '/':
        reqbody.request.response.write('hello world');
        await reqbody.request.response.close();
        break;
      case '/people':
        dart_mongo.PeopleController(reqbody, db);
        // if (reqbody.request.method == 'GET') {
        //   reqbody.request.response.write(await coll.find().toList());
        //   await reqbody.request.response.close();
        // }
        // else if (request.method == 'POST') {
        //   var content =
        //       await request.cast<List<int>>().transform(Utf8Decoder()).join();
        //   request.response.write(content);
        //   var data = json.decode(content);
        //   print(data['name']);
        //   await coll.save(data);
        //   // print(coll.findOne(content));
        //   await request.response.close();
        // } else if (request.method == 'PUT') {
        //   var id = int.parse(request.uri.queryParameters['id']);
        //   var content =
        //       await request.cast<List<int>>().transform(Utf8Decoder()).join();
        //   var document = jsonDecode(content);
        //   var iteamtochange = await coll.findOne(where.eq('id', id));
        //   if (iteamtochange == null) {
        //     await coll.save(document);
        //   } else {
        //     await coll.update(iteamtochange, document);
        //   }
        // } else if (request.method == 'DELETE') {
        //   var id = int.parse(request.uri.queryParameters['id']);
        //   var iteamtoremove = await coll.findOne(where.eq('id', id));
        //   await coll.remove(iteamtoremove);
        // } else if (request.method == 'PATCH') {
        //   var id = int.parse(request.uri.queryParameters['id']);
        //   var content =
        //       await request.cast<List<int>>().transform(Utf8Decoder()).join();
        //   var document = json.decode(content);
        //   var iteamtopatch = await coll.findOne(where.eq('id', id));
        //   await coll.update(iteamtopatch, {
        //     r'$set': document,
        //   });
        // }
        // await reqbody.request.response.close();
        break;
      default:
        reqbody.request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found');
        await reqbody.request.response.close();
    }
    print("xxxxxxxxxxxxxxxxxxxxxx");
    //  await request.response.close();
    // await db.close();
    // await server.close();

    // await db.close();// await server.close();
  });
  print("yyyyyyyyyyxxxxxxxxxxxxxx");
  // await db.close();
  // await server.close();
//  await db.close();

  ///lets read the db:
  // var people =
  //     await coll.find().toList(); //returns all the data in the collection

  //await coll.find(where.eq("first_name", "Hilton")).toList(); //returns datas whose first name equals to "Hilton";

  //await coll.findOne(where.gt('id', 40)); //returns one data whose id is greater than 40;

  //  await coll.findOne(where.jsQuery('''
  // return this.first_name.startsWith("A") && this.id > 10;
  // ''')); //returns one data whose firstname starts with "A", and id is greater than 10

  // print(people);

  ///lets create a new document in database called test collection called people.
  // await coll.save({
  //   'id': 101,
  //   'first_name': 'Arvind',
  //   'email': 'arvindsuresh2002@gmail.com',
  //   'gender': 'male',
  //   'ip_address': '63.90.69.20',
  // }); //this is how we save a new document

  // var people = await coll.findOne(where.eq('first_name', 'Arvind'));
  // print(people); // printing the document saved.

  ///lets update the document saved.

  // await coll.update(await coll.findOne(where.eq('first_name', 'Arvind')), {
  //   r'$set': {
  //     'first_name': 'Arvind S',
  //   }
  // }); // thats how we update a specific field in an document keeping other fields ideal

  // await coll.update(await coll.findOne(where.eq('first_name', 'Arvind')), {
  //     'first_name': 'Arvind S',
  // }); //this updates an whole document whose firstname is 'Arvind' to just one field  ie 'firstname' : 'Arvind';

  // print(await coll.findOne(where.eq('id', 101)));//print the updated document with its id.

  ///lets remove a document

  // await coll.remove(await coll.findOne(where.eq('id', 101)));
  // await coll
  //     .remove(where.eq('id', 101)); //removes all the document whose id is 101
  //people = await coll.find(where.eq('id', 101)).toList();
  //print(people); //it should print null;
}
