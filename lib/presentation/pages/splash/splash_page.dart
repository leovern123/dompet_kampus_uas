import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/services/deeplink_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../injection/injection_container.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showBiometric = false;
  bool _biometricLoading = false;
  final _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final storage = sl<SecureStorageDatasource>();
    final token = await storage.getToken();
    final biometricEnabled = await storage.getBiometricEnabled();

    if (!mounted) return;

    if (token != null && biometricEnabled) {
      // Ada sesi tersimpan + biometrik aktif → tampilkan tombol sidik jari
      setState(() => _showBiometric = true);
    } else if (token != null) {
      // Ada sesi tersimpan tapi biometrik tidak aktif → auto login
      context.read<AuthBloc>().add(AuthCheckRequested());
    }
    // Tidak ada token → tampilkan welcome screen (tidak perlu action)
  }

  Future<void> _triggerBiometric() async {
    setState(() => _biometricLoading = true);
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Masuk ke Dompet Kampus Global',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
      if (!mounted) return;
      if (authenticated) {
        // Tunggu dialog biometrik sepenuhnya dismiss + frame selesai render
        await Future.delayed(const Duration(milliseconds: 600));
        if (!mounted) return;
        context.read<AuthBloc>().add(AuthCheckRequested());
      } else {
        setState(() { _showBiometric = false; _biometricLoading = false; });
      }
    } catch (_) {
      if (mounted) setState(() { _showBiometric = false; _biometricLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          final pending = DeeplinkService.consumePending();
          if (pending != null) {
            context.go('/pay', extra: pending);
          } else {
            context.go('/home');
          }
        } else if (state is AuthUnauthenticated) {
          setState(() { _showBiometric = false; _biometricLoading = false; });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -120,
                  right: -90,
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  left: -100,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const Spacer(),
                      const AppLogo(size: 92, light: true),
                      const SizedBox(height: 26),
                      const Text(
                        'Dompet Kampus',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'GLOBAL',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Bayar, transfer, dan kelola uang kuliah\ndalam satu aplikasi yang aman.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      if (_showBiometric)
                        _buildBiometricSection()
                      else
                        _buildWelcomeButtons(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _biometricLoading ? null : _triggerBiometric,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
            ),
            child: _biometricLoading
                ? const Center(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    ),
                  )
                : const Icon(Icons.fingerprint_rounded, size: 44, color: Colors.white),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Ketuk untuk masuk dengan biometrik',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => setState(() => _showBiometric = false),
          child: Text(
            'Gunakan kata sandi',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeButtons() {
    return Column(
      children: [
        AppButton(
          label: 'Buat Akun Baru',
          variant: AppButtonVariant.white,
          onPressed: () => context.push('/register'),
        ),
        const SizedBox(height: 11),
        AppButton(
          label: 'Masuk ke Akun',
          variant: AppButtonVariant.outlineWhite,
          onPressed: () => context.push('/login'),
        ),
      ],
    );
  }
}
