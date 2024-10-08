package zentasktic_project

import (
	"bytes"
	"gno.land/p/demo/zentasktic"
)

type ActorsObject struct {
	Actors	[]*Actor
}

type TeamsObject struct {
	Teams	[]*Team
}

type TeamTasksObject struct {
    TeamId    string         `json:"teamId"`
    TeamTasks []zentasktic.Task `json:"tasks"`
}

type TeamsTasksObject struct {
	TeamsTasks []TeamTasksObject `json:"teamsTasks"`
}

type RewardsPointsObject struct {
	RewardsPoints	[]*RewardsPoint
}

func (a Actor) MarshalJSON() ([]byte, error) {

	var b bytes.Buffer
	//if a == nil {
    //    return nil, errors.New("actor is nil")
    //}
	b.WriteByte('{')

	b.WriteString(`"actorId":"`)
	b.WriteString(a.Id)
	b.WriteString(`",`)

	b.WriteString(`"actorName":"`)
	b.WriteString(a.Name)
	b.WriteString(`",`)

	b.WriteString(`"actorAddress":"`)
	b.WriteString(string(a.Address))
	b.WriteString(`"`)

	b.WriteByte('}')

	return b.Bytes(), nil
}

func (ao ActorsObject) MarshalJSON() ([]byte, error) {
	var b bytes.Buffer

	b.WriteString(`{"actors":[`)
	
	for i, actor := range ao.Actors {
		if i > 0 {
			b.WriteString(`,`)
		}
		actorJSON, cerr := actor.MarshalJSON()
		if cerr == nil {
			b.WriteString(string(actorJSON))
		}
	}

	b.WriteString(`]}`)

	return b.Bytes(), nil
}

func (t Team) MarshalJSON() ([]byte, error) {

	var b bytes.Buffer
	//if t == nil {
    //    return nil, errors.New("team is nil")
    //}
	
	b.WriteByte('{')

	b.WriteString(`"teamId":"`)
	b.WriteString(t.Id)
	b.WriteString(`",`)

	b.WriteString(`"teamName":"`)
	b.WriteString(t.Name)
	b.WriteString(`",`)

	b.WriteString(`"teamMembers":[`)

	if len(t.Members) != 0 {
		for i, actorId := range t.Members {
			if i > 0 {
				b.WriteString(`,`)
			}
			actor, err := GetActorById(actorId)
			if err == nil {
				teamMemberJSON, perr := actor.MarshalJSON()
				if perr == nil {
					b.WriteString(string(teamMemberJSON))
				}
			}
		}
	}

	b.WriteString(`]`)

	b.WriteByte('}')

	return b.Bytes(), nil
}

func (to TeamsObject) MarshalJSON() ([]byte, error) {
	var b bytes.Buffer

	b.WriteString(`{"teams":[`)
	
	for i, team := range to.Teams {
		if i > 0 {
			b.WriteString(`,`)
		}
		teamJSON, cerr := team.MarshalJSON()
		if cerr == nil {
			b.WriteString(string(teamJSON))
		}
	}

	b.WriteString(`]}`)

	return b.Bytes(), nil
}

func (tto TeamsTasksObject) MarshalJSON() ([]byte, error) {
    var b bytes.Buffer

    b.WriteString(`{"teamsTasks":[`)

    for m, teamTaskObject := range tto.TeamsTasks {
        if m > 0 {
            b.WriteString(`,`)
        }
        b.WriteString(`{"teamId":"`)
        b.WriteString(teamTaskObject.TeamId)
        b.WriteString(`", "tasks":[`)
        for i, task := range teamTaskObject.TeamTasks {
            if i > 0 {
                b.WriteString(`,`)
            }
            taskJSON, err := task.MarshalJSON()
            if err != nil {
                return nil, err
            }
            b.WriteString(string(taskJSON))
        }
        b.WriteString(`]}`)
    }

    b.WriteString(`]}`)

    return b.Bytes(), nil
}

func (rp RewardsPoint) MarshalJSON() ([]byte, error) {

	var b bytes.Buffer
	
	b.WriteByte('{')

	b.WriteString(`"rewardsPointId":"`)
	b.WriteString(rp.Id)
	b.WriteString(`",`)

	b.WriteString(`"objectId":"`)
	b.WriteString(rp.ObjectId)
	b.WriteString(`",`)

	b.WriteString(`"objectType":"`)
	b.WriteString(rp.ObjectType)
	b.WriteString(`",`)

	b.WriteString(`"rewardsPointsAmount":"`)
	b.WriteString(string(rp.Amount.String()))
	b.WriteString(`",`)

	b.WriteString(`"rewardsPointsStatus":"`)
	b.WriteString(rp.Status)
	b.WriteString(`"`)

	b.WriteByte('}')

	return b.Bytes(), nil
}

func (ro RewardsPointsObject) MarshalJSON() ([]byte, error) {
	var b bytes.Buffer

	b.WriteString(`{"rewardsPoints":[`)
	
	for i, rewardsPoint := range ro.RewardsPoints {
		if i > 0 {
			b.WriteString(`,`)
		}
		rewardsPointJSON, cerr := rewardsPoint.MarshalJSON()
		if cerr == nil {
			b.WriteString(string(rewardsPointJSON))
		}
	}

	b.WriteString(`]}`)

	return b.Bytes(), nil
}