part of '../register_user_screen.dart';

class _RegisterUserForm extends StatelessWidget {
  const _RegisterUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterUserBloc>();

    return Form(
      key: bloc.formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              0.verticalSpace,
              const _UFIcon(),
              48.verticalSpace,
              Text(
                "You Can Sign Up by Filling This Form",
                style: context.text.titleLarge?.copyWith(color: context.color.primary, fontSize: 24),
              ),
              34.verticalSpace,
              MGTextField(
                controller: bloc.name,
                label: "Name",
              ),
              23.verticalSpace,
              MGTextField(
                controller: bloc.email,
                label: "Email",
              ),
              23.verticalSpace,
              MGTextField(
                controller: bloc.password,
                label: "Password",
              ),
              33.verticalSpace,
              CBElevatedButton(
                label: "Register",
                fillParent: true,
                onPressed: () {
                  context.read<RegisterUserBloc>().add(RegisterUserRequested(
                      email: bloc.email.text, password: bloc.password.text, name: bloc.name.text));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UFIcon extends StatelessWidget {
  const _UFIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      color: context.color.primary,
    );
  }
}
