s1 = [40, 65, 90, 115, 140];
s2 = [30, 60, 90, 120, 150];

clear all
GW = createGridWorld(5, 5, 'Standard')
GW.CurrentState = '[1,1]';
%GW.TerminalStates = '[5,5]';
%GW.ObstacleStates = ["[3,3]";"[3,4]";"[3,5]";"[4,3]"];

%updateStateTranstionForObstacles(GW)
%GW.T(state2idx(GW,"[2,4]"),:,:) = 0;
%GW.T(state2idx(GW,"[2,4]"),state2idx(GW,"[4,4]"),:) = 1;

nS = numel(GW.States);
nA = numel(GW.Actions);
GW.R = -1*ones(nS,nS,nA); %-1*
GW.R(state2idx(GW,"[5,5]"),state2idx(GW,"[5,4]"),4) = 5;
GW.R(state2idx(GW,"[5,4]"),state2idx(GW,"[5,3]"),4) = 5;
GW.R(state2idx(GW,"[5,3]"),state2idx(GW,"[5,2]"),4) = 5;
GW.R(state2idx(GW,"[5,2]"),state2idx(GW,"[5,1]"),4) = 5;

GW.R(state2idx(GW,"[5,4]"),state2idx(GW,"[5,5]"),3) = -5;
GW.R(state2idx(GW,"[5,3]"),state2idx(GW,"[5,4]"),3) = -5;
GW.R(state2idx(GW,"[5,2]"),state2idx(GW,"[5,3]"),3) = -5;
GW.R(state2idx(GW,"[5,1]"),state2idx(GW,"[5,2]"),3) = -5;


env = rlMDPEnv(GW)
%plot(env)

qTable = rlTable(getObservationInfo(env),getActionInfo(env));
tableRep = rlRepresentation(qTable);
tableRep.Options.LearnRate = 1;

agentOpts = rlQAgentOptions;
agentOpts.EpsilonGreedyExploration.Epsilon = 0.9;%.04;
agentOpts.EpsilonGreedyExploration.EpsilonMin = 0.05;
agentOpts.EpsilonGreedyExploration.EpsilonDecay = 0.01;
qAgent = rlQAgent(tableRep,agentOpts);

trainOpts = rlTrainingOptions;
%trainOpts.MaxStepsPerEpisode = 50000;
%trainOpts.MaxEpisodes= 5;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 2500;
trainOpts.ScoreAveragingWindowLength = 30;

 plot(env);
 trainingStats = train(qAgent,env,trainOpts);
 
 figure 
 plot(env);
env.Model.Viewer.ShowTrace = true;
%env.Model.Viewer.clearTrace;
experience=sim(qAgent,env)
