import 'package:contact/contact_model.dart';
import 'package:contact/db_heleper.dart';
import 'package:rxdart/subjects.dart';

class GetListBloc{
  final DataBaseHelper _baseHelper = DataBaseHelper();
  final _fetchGetBaseInfo = PublishSubject<List<ContactModel>>();
  Stream<List<ContactModel>> get getBaseStream => _fetchGetBaseInfo.stream;


  getBaseAll()async{
    List<ContactModel> data = await _baseHelper.malumotlarniolish();
    _fetchGetBaseInfo.sink.add(data);
  }

}
final contactBloc = GetListBloc();