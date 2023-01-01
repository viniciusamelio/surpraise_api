import 'package:surpraise_core/surpraise_core.dart';

abstract class MemberMapper {
  static AddMembersInput fromMap(Map<String, dynamic> map) {
    return AddMembersInput(
      idCommunity: map["idCommunity"],
      members: (map["members"] as List)
          .map(
            (e) => memberFromMap(e),
          )
          .toList(),
    );
  }

  static MemberToAdd memberFromMap(Map<String, dynamic> map) {
    return MemberToAdd(
      idMember: map["idMember"],
      role: map["role"],
    );
  }
}
