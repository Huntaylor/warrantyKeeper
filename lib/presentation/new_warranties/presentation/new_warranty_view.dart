import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_checkbox.dart';
import 'package:warranty_keeper/widgets/warranty_image_widget.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class NewWarrantyView extends StatelessWidget {
  static const routeName = '/newWarrantyView';
  const NewWarrantyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
          builder: (context, state) {
            return Text(
              (state.isEditing)
                  ? appLocalizations.editWarrantyTitle
                  : appLocalizations.addWarrantyTitle,
            );
          },
        ),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newWarrantyCubit = context.read<NewWarrantyCubit>();
    final currWarrantyCubit = context.read<CurrentWarrantiesCubit>();
    final navCubit = context.read<NavCubit>();
    final appLocalizations = context.appLocalizations;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    WarrantyTextField.general(
                      initialValue: newWarrantyCubit.state.name ?? '',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeProductName,
                      hintText: appLocalizations.productName,
                    ),
                    WarrantyTextField.date(
                      initialValue: newWarrantyCubit.state.purchaseDate != null
                          ? '${_dateFormat(newWarrantyCubit.state.purchaseDate!)}'
                          : '${_dateFormat(DateTime.now())}',
                      isRequired: true,
                      isLifeTime: false,
                      endDateTime: DateTime(2050),
                      initialDateTime: DateTime.now(),
                      startDateTime: DateTime(2000),
                      onChanged: newWarrantyCubit.changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      initialValue:
                          newWarrantyCubit.state.warrWebsite ?? 'https://',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.lifeTime != current.lifeTime,
                      builder: (context, state) {
                        return WarrantyTextField.date(
                          initialValue: newWarrantyCubit.state.endOfWarr != null
                              ? '${_dateFormat(newWarrantyCubit.state.endOfWarr!)}'
                              : '',
                          isRequired: true,
                          isLifeTime: state.lifeTime,
                          endDateTime: DateTime(2050),
                          initialDateTime: newWarrantyCubit.state.endOfWarr ??
                              DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 1,
                              ),
                          startDateTime: DateTime.now(),
                          onChanged: newWarrantyCubit.changeEndDate,
                          hintText: appLocalizations.expirationDate,
                        );
                      },
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.lifeTime != current.lifeTime,
                      builder: (context, state) {
                        return WarrantyCheckBox(
                          isChecked: state.lifeTime,
                          text: appLocalizations.lifeTime,
                          onTap: newWarrantyCubit.toggleLifeTime,
                        );
                      },
                    ),
                    WarrantyTextField.form(
                      initialValue: newWarrantyCubit.state.details ?? '',
                      onChanged: newWarrantyCubit.changeAddtionalDetails,
                      hintText: appLocalizations.additionalDetails,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.receiptImage != current.receiptImage,
                      builder: (context, state) {
                        return WarrantyImage(
                          image: state.receiptImage,
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: false,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    25,
                                  ),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return ImageBottomSheet(
                                  onRecieptPhotoTap:
                                      newWarrantyCubit.changeReceiptPhotos,
                                  onRecieptCameraTap:
                                      newWarrantyCubit.changeReceiptCamera,
                                );
                              },
                            );
                          },
                          text: appLocalizations.addReceipt,
                          icon: const Icon(
                            Icons.list_alt_outlined,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.image != current.image,
                      builder: (context, state) {
                        return /* Row(
                          children: [ */
                            WarrantyImage(
                          image: state.image,
                          // fileList: state.imagesList,
                          onTap: () {
                            showModalBottomSheet(
                              enableDrag: false,
                              isScrollControlled: false,
                              isDismissible: false,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    25,
                                  ),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return ImageBottomSheet(
                                  onRecieptPhotoTap:
                                      newWarrantyCubit.changeProductPhotos,
                                  onRecieptCameraTap:
                                      newWarrantyCubit.changeProductCamera,
                                );
                              },
                            );
                          },
                          text:
                              '${appLocalizations.addPhoto} ${appLocalizations.required}',
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                        );
                        /*  Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * .1,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ); */
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                  child: WarrantyElevatedButton(
                    isEnabled: newWarrantyCubit.verifyWarranty(),
                    onPressed: () async {
                      if (newWarrantyCubit.verifyWarranty()) {
                        newWarrantyCubit.changeEditing();
                        currWarrantyCubit.addOrEditWarranty(state);
                        newWarrantyCubit.clear();
                        navCubit.pop();
                      }
                    },
                    text: (state.isEditing)
                        ? appLocalizations.editProductBtn
                        : appLocalizations.addproductButton,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
