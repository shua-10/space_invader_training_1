extends BulletUpgrades
class_name BulletDamageUpgrade

func apply_upgrades(bullet: Bullet):
	bullet.attack_damage += 1
