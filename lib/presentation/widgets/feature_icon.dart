import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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

// Map design icon names to HugeIcons
class DkgIcons {
  static const IconData home = HugeIcons.strokeRoundedHome01;
  static const IconData history = HugeIcons.strokeRoundedTimeHalfPass;
  static const IconData scan = HugeIcons.strokeRoundedQrCode01;
  static const IconData gift = HugeIcons.strokeRoundedGift;
  static const IconData user = HugeIcons.strokeRoundedUser;
  static const IconData send = HugeIcons.strokeRoundedSent;
  static const IconData wallet = HugeIcons.strokeRoundedWallet01;
  static const IconData plus = HugeIcons.strokeRoundedAdd01;
  static const IconData bell = HugeIcons.strokeRoundedNotification01;
  static const IconData eye = HugeIcons.strokeRoundedEye;
  static const IconData eyeOff = HugeIcons.strokeRoundedViewOff;
  static const IconData shield = HugeIcons.strokeRoundedShield01;
  static const IconData shieldCheck = HugeIcons.strokeRoundedShieldUser;
  static const IconData check = HugeIcons.strokeRoundedTick01;
  static const IconData mail = HugeIcons.strokeRoundedMail01;
  static const IconData lock = HugeIcons.strokeRoundedLockKey;
  static const IconData phone = HugeIcons.strokeRoundedCall;
  static const IconData copy = HugeIcons.strokeRoundedCopy01;
  static const IconData bank = HugeIcons.strokeRoundedBank;
  static const IconData arrowLeft = HugeIcons.strokeRoundedArrowLeft01;
  static const IconData arrowRight = HugeIcons.strokeRoundedArrowRight01;
  static const IconData chevRight = HugeIcons.strokeRoundedArrowRight02;
  static const IconData chevDown = HugeIcons.strokeRoundedArrowDown02;
  static const IconData topup = HugeIcons.strokeRoundedArrowUp01;
  static const IconData bill = HugeIcons.strokeRoundedReceiptDollar;
  static const IconData pulsa = HugeIcons.strokeRoundedSmartPhone01;
  static const IconData more = HugeIcons.strokeRoundedMore;
  static const IconData close = HugeIcons.strokeRoundedCancel01;
  static const IconData search = HugeIcons.strokeRoundedSearch01;
  static const IconData fingerprint = HugeIcons.strokeRoundedFingerPrint;
  static const IconData key = HugeIcons.strokeRoundedKey01;
  static const IconData xcircle = HugeIcons.strokeRoundedXVariableCircle;
  static const IconData info = HugeIcons.strokeRoundedInformationCircle;
  static const IconData qris = HugeIcons.strokeRoundedQrCode;
  static const IconData store = HugeIcons.strokeRoundedStore01;
  static const IconData link = HugeIcons.strokeRoundedLink01;
  static const IconData clock = HugeIcons.strokeRoundedClock01;
  static const IconData refresh = HugeIcons.strokeRoundedRefresh;
  static const IconData settings = HugeIcons.strokeRoundedSettings01;
  static const IconData logout = HugeIcons.strokeRoundedLogout01;
  static const IconData star = HugeIcons.strokeRoundedStar;
  static const IconData splitBill = HugeIcons.strokeRoundedReceiptDollar;
  static const IconData card = HugeIcons.strokeRoundedCreditCard;
  static const IconData food = HugeIcons.strokeRoundedRestaurant01;
  static const IconData smartphone = HugeIcons.strokeRoundedSmartPhone01;
  static const IconData arrowDown = HugeIcons.strokeRoundedArrowDown01;
  static const IconData lightning = HugeIcons.strokeRoundedFlash;
  static const IconData wifi = HugeIcons.strokeRoundedWifi01;
  static const IconData heart = HugeIcons.strokeRoundedFavourite;
  static const IconData linkOff = HugeIcons.strokeRoundedXVariableCircle;
  static const IconData shoppingBag = HugeIcons.strokeRoundedShoppingBag01;
  static const IconData google = HugeIcons.strokeRoundedGoogleDrive;
  static const IconData voucher = HugeIcons.strokeRoundedTicket01;
}
