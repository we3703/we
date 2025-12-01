import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/referral/referral_node_entity.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/screens/referral/referral_view_model.dart';

class ReferralTreeWidget extends StatefulWidget {
  const ReferralTreeWidget({super.key});

  @override
  State<ReferralTreeWidget> createState() => _ReferralTreeWidgetState();
}

class _ReferralTreeWidgetState extends State<ReferralTreeWidget> {
  BuchheimWalkerConfiguration buchheimWalkerConfiguration =
      BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    buchheimWalkerConfiguration
      ..siblingSeparation = (100)
      ..levelSeparation = (100)
      ..subtreeSeparation = (100)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReferralViewModel>().getReferralTree();
    });
  }

  void _buildGraphFromEntity(
    Graph graph,
    ReferralNodeEntity node,
    Map<String, Node> nodeMap,
    Node? parentNode,
  ) {
    // Create a node with user name and level
    final nodeKey = '${node.name}\n(${node.level})';
    final graphNode = Node.Id(nodeKey);
    nodeMap[node.userId] = graphNode;

    graph.addNode(graphNode);

    if (parentNode != null) {
      graph.addEdge(parentNode, graphNode);
    }

    // Recursively add children
    for (final child in node.children) {
      _buildGraphFromEntity(graph, child, nodeMap, graphNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReferralViewModel>(
      builder: (context, referralVM, child) {
        if (referralVM.isLoading && referralVM.referralTree == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (referralVM.errorMessage != null) {
          return Center(child: Text(referralVM.errorMessage!));
        }

        final referralTree = referralVM.referralTree;
        if (referralTree == null) {
          return const Center(child: Text('추천 트리 정보를 불러올 수 없습니다.'));
        }

        // Build graph from entity
        final Graph graph = Graph();
        final Map<String, Node> nodeMap = {};
        _buildGraphFromEntity(graph, referralTree, nodeMap, null);

        return Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.1,
                maxScale: 2.0,
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(
                    buchheimWalkerConfiguration,
                    TreeEdgeRenderer(buchheimWalkerConfiguration),
                  ),
                  builder: (Node node) {
                    // Widget for each node
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped on ${node.key!.value}')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: AppShadow.card,
                          color: AppColors.surface,
                        ),
                        child: Text(
                          node.key!.value as String,
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
