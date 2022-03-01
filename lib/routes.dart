import 'package:flutter/material.dart';
import 'package:warranty_keeper/presentation/barcode_scanner/barcode_scanner_view.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_keeper/presentation/settings/settings_view.dart';
import 'package:warranty_keeper/presentation/warranty_details/presentation/warranty_details_view.dart';

final appRoutes = {
  HomeView.routeName: (BuildContext context) => const HomeView(),
  NewWarrantyView.routeName: (BuildContext context) => const NewWarrantyView(),
  CurrentWarrantiesView.routeName: (BuildContext context) =>
      const CurrentWarrantiesView(),
  WarrantyDetailsView.routeName: (BuildContext context) =>
      const WarrantyDetailsView(),
  SettingsView.routeName: (BuildContext context) => const SettingsView(),
  BarcodeScannerView.routeName: (BuildContext context) =>
      const BarcodeScannerView(),
};
