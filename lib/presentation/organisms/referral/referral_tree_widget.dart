import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/referral/referral_node_entity.dart';
import 'package:we/presentation/molecules/cards/user/user_status_card.dart';
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
    Map<String, ReferralNodeEntity> entityMap,
    Node? parentNode,
  ) {
    // Create a node with user ID as key
    final graphNode = Node.Id(node.userId);
    nodeMap[node.userId] = graphNode;
    entityMap[node.userId] = node;

    graph.addNode(graphNode);

    if (parentNode != null) {
      graph.addEdge(parentNode, graphNode);
    }

    // Recursively add children
    for (final child in node.children) {
      _buildGraphFromEntity(graph, child, nodeMap, entityMap, graphNode);
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
        final Map<String, ReferralNodeEntity> entityMap = {};
        _buildGraphFromEntity(graph, referralTree, nodeMap, entityMap, null);

        // Convert level string to MembershipLevel enum
        MembershipLevel convertLevel(String level) {
          switch (level.toUpperCase()) {
            case 'MASTER':
              return MembershipLevel.master;
            case 'DIAMOND':
              return MembershipLevel.diamond;
            case 'GOLD':
              return MembershipLevel.gold;
            case 'SILVER':
              return MembershipLevel.silver;
            case 'BRONZE':
              return MembershipLevel.bronze;
            default:
              return MembershipLevel.none;
          }
        }

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
                    // Get entity data for this node
                    final userId = node.key!.value as String;
                    final entity = entityMap[userId];

                    if (entity == null) {
                      return const SizedBox.shrink();
                    }

                    // Widget for each node using UserStatusCard
                    return SizedBox(
                      width: 200, // Fixed width for consistency in tree
                      child: UserStatusCard(
                        userName: entity.name,
                        membershipLevel: convertLevel(entity.level),
                        joinDate: entity.joinedAt,
                        recommendationCount: entity.children.length,
                        profileImageUrl: null,
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
