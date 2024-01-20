abstract class UseCase<Type, Param> {
  Type call(final Param param);
}