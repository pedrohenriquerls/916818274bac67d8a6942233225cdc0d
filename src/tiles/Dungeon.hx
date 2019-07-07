package src.tiles;
import h2d.TileGroup;
import h2d.Tile;

enum DungeonTile {
    FloorCommon;
    FloorCracked;
    FloorCracked2;
    FloorCracked3;
    FloorCracked4;
    FloorCracked5;
    FloorCracked6;
    FloorCracked7;
}

class Dungeon {
    static inline var TILE_SIZE = 16;
    static inline var SCALE_SIZE = 2;
    var tiles: Tile;
    var map: Map<DungeonTile, Tile>;

    public function new() {
        tiles = hxd.Res.dungeon_tiles.toTile();
        mapTiles();
        scaleTiles();
    }

    function mapTiles() {
        map = new Map<DungeonTile, Tile>();
        map[DungeonTile.FloorCommon] = tiles.sub(0, 0, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked] = tiles.sub(0, TILE_SIZE, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked2] = tiles.sub(0, TILE_SIZE * 2, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked3] = tiles.sub(0, TILE_SIZE * 3, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked4] = tiles.sub(0, TILE_SIZE * 4, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked5] = tiles.sub(0, TILE_SIZE * 5, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked6] = tiles.sub(0, TILE_SIZE * 6, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked7] = tiles.sub(0, TILE_SIZE * 7, TILE_SIZE, TILE_SIZE);
    }

    function scaleTiles() {
        for (tile in map.iterator()) {
            tile.scaleToSize(scaledSize(), scaledSize());
        }
    }

    function scaledSize(): Float {
        return TILE_SIZE * SCALE_SIZE;
    }

    public function renderTileMap(tileMap: Array<Array<DungeonTile>>): TileGroup {
        var group = new TileGroup(tiles);
        for (index in 0...tileMap.length) {
            var listTileKey = tileMap[index];
            for (tileKeyIndex in 0...listTileKey.length) {
                var tileKey = listTileKey[tileKeyIndex];
                if (tileKey == null) {
                    continue;
                }
                var tile = map[tileKey];
                group.add(index * scaledSize(), tileKeyIndex * scaledSize(), tile);
            }
        }
        return group;
    }
}