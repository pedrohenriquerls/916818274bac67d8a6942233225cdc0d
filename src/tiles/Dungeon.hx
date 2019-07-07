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
    FloorLadder;

    WallTopLeft;
    WallTopMid;
    WallTopRight;
    WallLeft;
    WallMid;
    WallRight;
    WallHole1;
    WallHole2;
}

class Dungeon {
    static inline var TILE_SIZE = 16;
    static inline var SCALE_SIZE = 2;
    var tiles: Tile;
    var map: Map<DungeonTile, Tile>;

    public function new() {
        tiles = hxd.Res.dungeon_tiles_set.toTile();
        mapTiles();
        scaleTiles();
    }

    function mapTiles() {
        map = new Map<DungeonTile, Tile>();
        map[DungeonTile.FloorCommon] = tiles.sub(16, 64, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked] = tiles.sub(32, 64, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked2] = tiles.sub(48, 64, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked3] = tiles.sub(16, 80, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked4] = tiles.sub(32, 80, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked5] = tiles.sub(48, 80, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked6] = tiles.sub(16, 96, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorCracked7] = tiles.sub(32, 96, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.FloorLadder] = tiles.sub(48, 96, TILE_SIZE, TILE_SIZE);

        map[DungeonTile.WallTopLeft] = tiles.sub(16, 0, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallTopMid] = tiles.sub(32, 0, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallTopRight] = tiles.sub(48, 0, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallLeft] = tiles.sub(16, 16, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallMid] = tiles.sub(32, 16, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallRight] = tiles.sub(48, 16, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallHole1] = tiles.sub(48, 32, TILE_SIZE, TILE_SIZE);
        map[DungeonTile.WallHole2] = tiles.sub(48, 48, TILE_SIZE, TILE_SIZE);
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
        var realIndex = 0.0;
        for (index in 0...tileMap.length) {
            var listTileKey = tileMap[index];
            var previousTileMap = tileMap[index - 1];
            var nextTileMap = tileMap[index + 1];

            var currentIndex = realIndex;
            var topWall = index == 0 || (previousTileMap != null && previousTileMap.length == 0);
            var bottomWall = index == (tileMap.length - 1) || (nextTileMap != null && nextTileMap.length == 0); 
            for (tileKeyIndex in 0...listTileKey.length) {
                var positionX = tileKeyIndex * scaledSize();
                if (topWall) {
                    group.add(positionX, realIndex * scaledSize(), map[DungeonTile.WallTopLeft]);
                    realIndex += 1;
                    group.add(positionX, realIndex * scaledSize(), map[DungeonTile.WallLeft]);
                    realIndex += 1;
                }

                if (bottomWall) {
                    realIndex += 0.2;
                    group.add(positionX, realIndex * scaledSize(), map[DungeonTile.WallTopLeft]);
                    realIndex += 1;
                    group.add(positionX, realIndex * scaledSize(), map[DungeonTile.WallLeft]);
                }

                realIndex = currentIndex;
            }

            if (topWall) {
                realIndex += 2;
            }

            if (bottomWall) {
                // realIndex += 1.2;
            }

            for (tileKeyIndex in 0...listTileKey.length) {
                var positionX = tileKeyIndex * scaledSize();

                var tileKey = listTileKey[tileKeyIndex];
                if (tileKey == null) {
                    continue;
                }

                var tile = map[tileKey];
                group.add(tileKeyIndex * scaledSize(), realIndex * scaledSize(), tile);
            }
            realIndex += 1;
        }
        return group;
    }
}