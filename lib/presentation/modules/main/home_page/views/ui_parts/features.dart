part of '../home_page_screen.dart';

extension FeaturesUI on _HomePageScreenState {
  Widget _buildHomePageFeatures(HomePageState state) {
    final itemW = (device.width - 16 * 2) / 3;
    final imageH = itemW / 1.3;
    final items = [
      HighlightFeatureItem(
        icon: Assets.svg.icAddPeople,
        title: trans.inviteMember,
        onTap: onTapAddMember,
      ),
      HighlightFeatureItem(
        icon: Assets.svg.icJoinFamily,
        title: trans.joinFamily,
        onTap: onTapJoinFamily,
      ),
      HighlightFeatureItem(
        icon: Assets.svg.icFamilyInfo,
        title: trans.familyProfile,
        onTap: onTapFamilyProfile,
      ),
      HighlightFeatureItem(
        icon: Assets.svg.icAddLocation,
        title: trans.addLocation,
        onTap: onTapAddLocation,
      ),
      HighlightFeatureItem(
        icon: Assets.svg.icLocationList,
        title: trans.locationList,
        onTap: onTapLocationList,
      ),
      HighlightFeatureItem(
        icon: Assets.svg.icWallet,
        title: trans.message,
        onTap: onTapMessage,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trans.category,
            style: textTheme.bodyLarge,
          ),
          GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: imageH,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => items.elementAt(index),
            itemCount: items.length,
          ),
        ],
      ),
    );
  }

  Widget HighlightFeatureItem({
    required String icon,
    required String title,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: themeColor.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 36,
              height: 36,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title.capitalizeFirstofEach(),
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}

