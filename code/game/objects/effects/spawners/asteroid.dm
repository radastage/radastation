/obj/effect/asteroid
	var/maxX = 40
	var/maxY = 40
	var/minX = 2
	var/minY = 2

/obj/effect/asteroid/New(turf/location as turf,lX = minX,uX = maxX,lY = minY,uY = maxY)

	var/lowBoundX = location.x
	var/lowBoundY = location.y

	var/hiBoundX = location.x + rand(lX,uX)
	var/hiBoundY = location.y + rand(lY,uY)

	var/z = location.z

	for(var/i = lowBoundX,i<=hiBoundX,i++)
		for(var/j = lowBoundY,j<=hiBoundY,j++)
			if(i == lowBoundX || i == hiBoundX || j == lowBoundY || j == hiBoundY)
				new /turf/simulated/mineral/random(locate(i,j,z))
			else
				new /turf/simulated/mineral/random/high_chance(locate(i,j,z))

	del(src)
