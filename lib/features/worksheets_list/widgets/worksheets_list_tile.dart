import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WorksheetsListTile extends StatelessWidget {
  const WorksheetsListTile({
    super.key,
    required this.worksheetTitle,
  });

  final String worksheetTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        worksheetTitle,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        'Info',
        style: theme.textTheme.labelSmall,
      ),
      leading: SvgPicture.asset(
        'assets/svg/api.svg',
        height: 30,
      ),
      // trailing: const Icon(Icons.pending),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/worksheet', arguments: worksheetTitle,
          // MaterialPageRoute(builder: (context) => const WorksheetPage()),
        );
      },
    );
  }
}
