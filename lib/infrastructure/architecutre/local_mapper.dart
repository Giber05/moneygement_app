abstract class LocalMapper<Domain, Entity> {
  LocalMapper();

  Domain toDomain(Entity entity);

  Entity toEntity(Domain domain);
}
