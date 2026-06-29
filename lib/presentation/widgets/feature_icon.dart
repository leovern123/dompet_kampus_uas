import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/theme/app_colors.dart';

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;

  const FeatureIcon({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 52,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(size * 0.29),
      ),
      child: Center(
        child: Icon(icon, color: colors[1], size: iconSize),
      ),
    );
  }
}

// Map design icon names to Phosphor Icons
class DkgIcons {
  static final IconData home = PhosphorIcons.house();
  static final IconData history = PhosphorIcons.clockCounterClockwise();
  static final IconData scan = PhosphorIcons.scan();
  static final IconData gift = PhosphorIcons.gift();
  static final IconData user = PhosphorIcons.user();
  static final IconData send = PhosphorIcons.paperPlaneRight();
  static final IconData wallet = PhosphorIcons.wallet();
  static final IconData plus = PhosphorIcons.plus();
  static final IconData bell = PhosphorIcons.bell();
  static final IconData eye = PhosphorIcons.eye();
  static final IconData eyeOff = PhosphorIcons.eyeSlash();
  static final IconData shield = PhosphorIcons.shield();
  static final IconData shieldCheck = PhosphorIcons.shieldCheck();
  static final IconData check = PhosphorIcons.check();
  static final IconData mail = PhosphorIcons.envelope();
  static final IconData lock = PhosphorIcons.lockKey();
  static final IconData phone = PhosphorIcons.phone();
  static final IconData copy = PhosphorIcons.copy();
  static final IconData bank = PhosphorIcons.bank();
  static final IconData arrowLeft = PhosphorIcons.arrowLeft();
  static final IconData arrowRight = PhosphorIcons.arrowRight();
  static final IconData chevRight = PhosphorIcons.caretRight();
  static final IconData chevDown = PhosphorIcons.caretDown();
  static final IconData topup = PhosphorIcons.arrowUp();
  static final IconData bill = PhosphorIcons.receipt();
  static final IconData pulsa = PhosphorIcons.deviceMobile();
  static final IconData more = PhosphorIcons.dotsThree();
  static final IconData close = PhosphorIcons.x();
  static final IconData search = PhosphorIcons.magnifyingGlass();
  static final IconData fingerprint = PhosphorIcons.fingerprint();
  static final IconData key = PhosphorIcons.key();
  static final IconData xcircle = PhosphorIcons.xCircle();
  static final IconData info = PhosphorIcons.info();
  static final IconData qris = PhosphorIcons.qrCode();
  static final IconData store = PhosphorIcons.storefront();
  static final IconData link = PhosphorIcons.link();
  static final IconData clock = PhosphorIcons.clock();
  static final IconData refresh = PhosphorIcons.arrowClockwise();
  static final IconData settings = PhosphorIcons.gear();
  static final IconData logout = PhosphorIcons.signOut();
  static final IconData star = PhosphorIcons.star();
  static final IconData splitBill = PhosphorIcons.receipt();
  static final IconData card = PhosphorIcons.creditCard();
  static final IconData food = PhosphorIcons.forkKnife();
  static final IconData smartphone = PhosphorIcons.deviceMobile();
  static final IconData arrowDown = PhosphorIcons.arrowDown();
  static final IconData lightning = PhosphorIcons.lightning();
  static final IconData wifi = PhosphorIcons.wifiHigh();
  static final IconData heart = PhosphorIcons.heart();
  static final IconData linkOff = PhosphorIcons.linkBreak();
  static final IconData shoppingBag = PhosphorIcons.shoppingBag();
  static final IconData google = PhosphorIcons.googleLogo();
}
