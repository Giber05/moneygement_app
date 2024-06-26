part of '../login_screen.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

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
                "Welcome Back",
                style: context.text.titleLarge?.copyWith(color: context.color.primary, fontSize: 24),
              ),
              34.verticalSpace,
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
              MGElevatedButton(
                label: "Sign In",
                fillParent: true,
                onPressed: () {
                  context.read<LoginBloc>().add(LoginRequested(email: bloc.email.text, password: bloc.password.text));
                },
              ),
              24.verticalSpace,
              MGElevatedButton(
                label: "Sign Up",
                fillParent: true,
                onPressed: () {
                  context.router.push(const RegisterUserRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UFIcon extends StatelessWidget {
  const _UFIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      color: context.color.primary,
    );
  }
}
