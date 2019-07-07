import src.tiles.Dungeon;
import src.Layers;

class Main extends hxd.App {
    var anim:h2d.Anim;
    var layers: h2d.Layers;

    override function init() {
        // var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        // tf.text = "Hello World !";
        var ptiles = hxd.Res.enemies.demon.toTile();
        // var group = new h2d.TileGroup(ptiles, s2d);
        // group.add(100, 100, ptiles.sub(0, 0, 32, 36));
        anim = new h2d.Anim([
            ptiles.sub(0, 0, 32, 36), 
            ptiles.sub(0, 36, 32, 36), 
            ptiles.sub(0, 36*2, 32, 36)
        ], 8, s2d);
        anim.loop = true;
        anim.x = 0;
        s2d.addChildAt(anim, Layers.Chars.getIndex());
        // s2d.addChild(group);

        var dungeon = new Dungeon();
        dungeon.renderTileMap([
            [DungeonTile.FloorCommon, DungeonTile.FloorCommon, DungeonTile.FloorCommon],
            [DungeonTile.FloorCommon, DungeonTile.FloorCommon, DungeonTile.FloorCommon],
            [DungeonTile.FloorCommon, DungeonTile.FloorCommon, DungeonTile.FloorCommon],
            [],
            [DungeonTile.FloorCommon, DungeonTile.FloorCommon, DungeonTile.FloorCommon],
            [DungeonTile.FloorCommon, null, DungeonTile.FloorCommon],
            [DungeonTile.FloorCommon, DungeonTile.FloorCommon, DungeonTile.FloorCommon]
        ], s2d);
		//parts = new h2d.SpriteBatch(ptiles[0]);
    }

    override function update(dt:Float) {
        if (anim.x <= 0 || anim.x == null) {
            anim.x += 5;
        } else if(anim.x >= 100) {
            anim.x -= 5;
        }
        super.update(dt);
    }

    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}