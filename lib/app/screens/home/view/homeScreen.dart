import 'package:cart3d/app/components/appbar/customAppBar.dart';
import 'package:cart3d/app/components/common/glowing_loader.dart';
import 'package:cart3d/app/components/productCard/ProductCard.dart';
import 'package:cart3d/app/screens/home/controller/homecontroller.dart';
import 'package:cart3d/app/routes/AppRoutes.dart';
import 'package:cart3d/app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends GetView<Homecontroller> {
  Homescreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: Customappbar(title: 'Cart3D'),
      body: Padding(
        padding: AppStyles.pagePadding,
        child: Obx(
          () => LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 1100;
              return IndexedStack(
                index: controller.selectedTab.value,
                children: <Widget>[
                  _buildHomeTab(context, theme, constraints, isDesktop),
                  _buildPlaceholderTab(
                    context,
                    icon: Icons.favorite_border_rounded,
                    title: 'Saved Items',
                    subtitle: 'Your favorite products will appear here.',
                  ),
                  _buildPlaceholderTab(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: 'Shopping Cart',
                    subtitle: 'Add products to your cart to get started.',
                  ),
                  _buildProfileTab(context),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.setTab(0),
        child: const Icon(Icons.home_rounded),
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: theme.bottomNavigationBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _NavigationButton(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: controller.selectedTab.value == 0,
                  onTap: () => controller.setTab(0),
                ),
                _NavigationButton(
                  icon: Icons.favorite_rounded,
                  label: 'Saved',
                  selected: controller.selectedTab.value == 1,
                  onTap: () => controller.setTab(1),
                ),
                _NavigationButton(
                  icon: Icons.shopping_bag_rounded,
                  label: 'Cart',
                  selected: controller.selectedTab.value == 2,
                  onTap: () => controller.setTab(2),
                ),
                _NavigationButton(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  selected: controller.selectedTab.value == 3,
                  onTap: () => controller.setTab(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context, ThemeData theme, BoxConstraints constraints, bool isDesktop) {
    final productList = controller.filteredProducts;
    final crossAxisCount = constraints.maxWidth < 650
        ? 1
        : constraints.maxWidth < 1000
            ? 2
            : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Discover premium 3D products',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: controller.setSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search products, models or brands',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            searchController.clear();
                            controller.setSearchQuery('');
                          },
                        )
                      : null,
                ),
              ),
            ),
            if (isDesktop) ...[
              const SizedBox(width: 18),
              _buildHighlightCard(context),
            ]
          ],
        ),
        const SizedBox(height: 18),
        Text(
          controller.selectedTabLabel,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          '${productList.length} item${productList.length == 1 ? '' : 's'} found',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 18),
        Expanded(
          child: controller.products.isEmpty
              ? const Center(child: GlowingLoader(size: 46))
              : productList.isEmpty
                  ? Center(
                      child: Text(
                        searchController.text.isEmpty
                            ? 'No products available yet.'
                            : 'No products match your search.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(flex: 3, child: _buildProductGrid(productList, crossAxisCount)),
                            const SizedBox(width: 24),
                            Expanded(flex: 1, child: _buildDesktopSidebar(context)),
                          ],
                        )
                      : _buildProductGrid(productList, crossAxisCount),
        ),
      ],
    );
  }

  Widget _buildProductGrid(List productList, int crossAxisCount) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: crossAxisCount == 1 ? 1.05 : 0.72,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemBuilder: (context, index) {
        final product = productList[index];
        return Productcard(
          title: product.title,
          description: product.description,
          imgUrl: product.thumbnail,
          ontap: () => Get.toNamed(AppRoutes.product, arguments: product),
        );
      },
    );
  }

  Widget _buildHighlightCard(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: AppStyles.borderRadiusLg,
        border: Border.all(color: Theme.of(context).dividerColor),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Today’s pick', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(
            'Fast shipping, premium models and easy checkout for all your 3D needs.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => controller.setTab(1),
            child: const Text('View featured'),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Quick Info', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        const _InfoChip(label: 'Fast delivery'),
        const SizedBox(height: 10),
        const _InfoChip(label: 'Verified 3D models'),
        const SizedBox(height: 10),
        const _InfoChip(label: 'Secure payments'),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: () {},
          child: const Text('View all deals'),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 56, color: Theme.of(context).iconTheme.color),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: <Widget>[
        CircleAvatar(
          radius: 44,
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(36),
          child: const Icon(Icons.person_rounded, size: 40),
        ),
        const SizedBox(height: 18),
        Text('Welcome back!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Manage your account, orders and saved items.', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.receipt_long_rounded),
          title: const Text('Orders'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings_rounded),
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: const Text('Close'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => Get.back(),
        ),
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Theme.of(context).colorScheme.secondary : Theme.of(context).iconTheme.color;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: AppStyles.borderRadiusSm,
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
