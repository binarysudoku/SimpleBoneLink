/** 
Copyright 2017 James Somervail
*/

MainWindow = newRolloutFloater "SimpleBoneLink" 174 81

fn eulToVec eul =
	(
	x = cos(eul.y)*cos(eul.z)
	y = sin(eul.y)*cos(eul.z)
	z = sin(eul.z)
	return normalize [-x, z, y]
	)

fn linkBones par chi =
	(
	rot = eulToVec ( quattoeuler par.rotation )
	endpos = par.pos + (rot * -par.length)
	lbone = BoneSys.createBone endpos chi.pos [0,0,1]
	chi.parent = lbone
	lbone.parent = par
	)

global tarparent
global tarchild

rollout BoneLink "Bone Link" width:162 height:54
(
	pickButton 'selparent' "Parent" pos:[1,1] width:80 height:26 align:#left
	button 'apply' "Link Bones" pos:[1,28] width:160 height:25 align:#left
	
	on selparent picked obj do
		(
		if classof obj == BoneGeometry do
			(
			tarparent = obj
			)
		)
	
	on apply pressed do
		(
		for i in $selection as array do
			(
			linkBones tarparent i
			)
		)
)

addrollout BoneLink MainWindow