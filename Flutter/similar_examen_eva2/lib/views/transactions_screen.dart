import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:similar_examen_eva2/l10n/app_localizations.dart';

import '../viewmodels/converter_view_model.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  
  @override
  void initState() {
    super.initState();
    // 1. 在页面初始化时加载数据，而不是在 build 里
    // 使用 addPostFrameCallback 确保在界面构建完成后才去刷新数据，避免报错
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ConverterViewModel>().loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2. 依然使用 watch 来监听数据变化
    final viewModel = context.watch<ConverterViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // 如果没有 Appbar，这个页面可能会覆盖状态栏，建议检查是否需要
      // body: ...
      body: viewModel.transactions.isEmpty
          ? Center(child: Text(l10n.emptyHistory))
          : ListView.builder(
              itemCount: viewModel.transactions.length,
              itemBuilder: (context, index) {
                final item = viewModel.transactions[index];
                return Card( // 加个 Card 好看点
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.history),
                    title: Text(
                      '${item['inputValue']} ${item['fromUnit']} → ${item['toUnit']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // 保留两位小数显示结果
                    subtitle: Text('Result: ${item['resultValue'].toStringAsFixed(4)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // 删除功能
                        viewModel.deleteTransaction(item['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}