class RemoveMembersDto {
  const RemoveMembersDto({
    required this.communityId,
    required this.memberIds,
  });

  final String communityId;
  final List memberIds;
}
