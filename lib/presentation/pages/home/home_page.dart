import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/transaction_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hideBalance = false;

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(AccountLoadRequested());
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState is AuthAuthenticated ? authState.user : null;
        final firstName = user?.firstName ?? 'Kamu';
        final fullName = user?.name ?? 'User';

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, accountState) {
              final balance = accountState is AccountLoaded ? accountState.account.balance : 0.0;
              final txns =
                  accountState is AccountLoaded ? accountState.transactions : <TransactionEntity>[];
              final loading = accountState is AccountLoading;

              return RefreshIndicator(
                onRefresh: () async => context.read<AccountBloc>().add(AccountRefreshRequested()),
                color: AppColors.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildHeader(firstName, fullName),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildBalanceCard(balance, loading),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildActionRow(),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildPointsRow(),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildFeatureGrid(),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildDeeplinkBanner(),
                      ),
                      const SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildTransactions(txns),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeader(String firstName, String fullName) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 14, 20, 16),
      child: Row(
        children: [
          AppAvatar(name: fullName, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selamat datang 👋',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.5,
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w500,
                    )),
                Text(firstName,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                      letterSpacing: -0.3,
                    )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(DkgIcons.bell, size: 22, color: AppColors.primary),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(double balance, bool loading) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: AppColors.shadowPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppLogo(size: 28),
              const SizedBox(width: 8),
              const Text('Dompet Kampus',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _hideBalance = !_hideBalance),
                child: Icon(
                  _hideBalance ? DkgIcons.eyeOff : DkgIcons.eye,
                  size: 20,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Saldo kamu',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 4),
          loading
              ? const SizedBox(
                  height: 40,
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 2),
                    ),
                  ),
                )
              : Text(
                  _hideBalance ? CurrencyFormatter.maskBalance() : CurrencyFormatter.format(balance),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.6,
                  ),
                ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => context.go('/topup'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(DkgIcons.plus, size: 14, color: Colors.white),
                  const SizedBox(width: 5),
                  const Text('Isi Saldo',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow() {
    final actions = [
      {'icon': DkgIcons.topup, 'label': 'Top Up', 'color': AppColors.green, 'bg': AppColors.greenSurface, 'route': '/topup'},
      {'icon': DkgIcons.send, 'label': 'Transfer', 'color': AppColors.primary, 'bg': AppColors.primarySurface, 'route': '/transfer'},
      {'icon': DkgIcons.qris, 'label': 'Bayar', 'color': AppColors.violet, 'bg': AppColors.violetSurface, 'route': '/payment'},
      {'icon': DkgIcons.arrowDown, 'label': 'Tarik', 'color': AppColors.amber, 'bg': AppColors.amberSurface, 'route': '/topup'},
    ];
    return Row(
      children: actions.map((a) {
        return Expanded(
          child: GestureDetector(
            onTap: () => context.go(a['route'] as String),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: a['bg'] as Color,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(a['icon'] as IconData, size: 26, color: a['color'] as Color),
                ),
                const SizedBox(height: 7),
                Text(a['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate600,
                    )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPointsRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.shadowSoft,
            ),
            child: Row(
              children: [
                FeatureIcon(icon: DkgIcons.star, tone: 'amber', size: 38, iconSize: 19),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Poin Kampus',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.5,
                            color: AppColors.slate500,
                            fontWeight: FontWeight.w600)),
                    Text('1.250',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.shadowSoft,
            ),
            child: Row(
              children: [
                FeatureIcon(icon: DkgIcons.qris, tone: 'green', size: 38, iconSize: 19),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('KTM Digital',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.5,
                            color: AppColors.slate500,
                            fontWeight: FontWeight.w600)),
                    Text('Aktif',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      {'icon': DkgIcons.smartphone, 'label': 'Pulsa', 'tone': 'blue'},
      {'icon': DkgIcons.lightning, 'label': 'PLN', 'tone': 'amber'},
      {'icon': DkgIcons.food, 'label': 'Kantin', 'tone': 'red'},
      {'icon': DkgIcons.bill, 'label': 'UKT', 'tone': 'violet'},
      {'icon': DkgIcons.wifi, 'label': 'Paket Data', 'tone': 'green'},
      {'icon': DkgIcons.voucher, 'label': 'Voucher', 'tone': 'red'},
      {'icon': DkgIcons.heart, 'label': 'Donasi', 'tone': 'amber'},
      {'icon': DkgIcons.more, 'label': 'Lainnya', 'tone': 'slate'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.shadowSoft,
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 18,
        crossAxisSpacing: 0,
        children: features.map((f) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureIcon(
                    icon: f['icon'] as IconData, tone: f['tone'] as String, size: 52, iconSize: 25),
                const SizedBox(height: 8),
                Text(f['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate600,
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDeeplinkBanner() {
    return GestureDetector(
      onTap: () => context.go('/merchant'),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF312E81), Color(0xFF4338CA)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -30,
              top: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(DkgIcons.link, size: 24, color: Colors.white),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Coba bayar dari toko online',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                      SizedBox(height: 2),
                      Text('Simulasi checkout e-commerce → bayar via DKG',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            color: Colors.white70,
                          )),
                    ],
                  ),
                ),
                const Icon(DkgIcons.chevRight, size: 20, color: Colors.white60),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactions(List<TransactionEntity> txns) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Transaksi terakhir',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                )),
            GestureDetector(
              onTap: () => context.go('/history'),
              child: const Text('Lihat semua',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppColors.shadowSoft,
          ),
          child: txns.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text('Belum ada transaksi',
                        style: TextStyle(color: AppColors.slate400, fontFamily: 'Inter')),
                  ),
                )
              : Column(
                  children: txns
                      .take(4)
                      .toList()
                      .asMap()
                      .entries
                      .map((e) => TransactionRow(txn: e.value, divider: e.key > 0))
                      .toList(),
                ),
        ),
      ],
    );
  }
}
