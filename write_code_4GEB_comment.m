%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% it is a supplementary file to the paper by Berkemer et.al on the travelers dilemma 
%% submitted to Games and Economic Behavior (2023)
%% and refers to subsection 5.2, where the Jacobean is computed
%% (C) Rainer Berkemer -  2023-05-25

%% Prepares for exact computaion of the jacobean for the travelers dilemma
%% REMARK for comparison - we look at the construction for 8 options (often this specific payoff table is recalled)

% This program code can be best understood if one refers to the introducimng sentences in the proof of Lemma 1 of the paper

%For each possible payoff value pi there are at most three explanations
%why it can occur in the payoff matrix and this follows compellingly from the
%very definition of the traveler’s dilemma:

   % (1) Both players claim exactly payoff pi - then this payoff value is in the main diagonal.
   
   % (2) The first player manages to undercut the other. Then the payoff pi is next to the right of the main diagonal 
   %     and because of R = 2 exactly in the row where pi ? 2 is in the main diagonal. Only in this case can a payoff 
   %     value occur more than once in a row.
   
   % (3) The other player manages to undercut the first. Then the payoff pi is below the main diagonal and because of 
   %     R = 2 exactly in the column where pi+2

% the main idea is to collect in a variable 'contributions' for each possible payoff the contribution for a specific 
% winning probability.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% payoffs 2 and 3 are special because they never fall in case (2) category
%% payoffs (m-1), m, and (m+1) are special because they never fall into case (3) category
 
%% all payoff values in between have all three cases above - this we call the 'normal' 3-type payoff
% with all the winning_prob_ties ... the worst will alway be 3-type starting with payoff 4
% WE WILL ALWAYS get options  (1  3  6  7  8 ... m) which might tie  - in  total we have m-3 possible ties simultaneously
%
% we will get a common multiplier smult = [s2*s3*s4]  in this case

%% divisors will then run from  (1/m-3) ... to 1
% cases in principal:
%
%     (1/m-3) * [s2*s3*s4] * (1-x1) * x3 * x5^(m-5) ....  when all of these options tie simultaneously


clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20  s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 

x= [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20];
s= [s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% the number of options might be any value between m=2 and m=20
m=4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ecount_list = 0; % later we always update [ecount_list,event_count];

%% an additional benefit of the code is, that it counts all 'compound' events necessary
%% because of many ties this involves more than 500000 compound events for m=20
%% For m=4, however, everything remains manageable for scholars without this algorithm 
%% that is why we have treated this case in detail in section 4.


display('    *************************************************************************************************');
display('************                        START ALGORITHM FOR ' + string(m) +' OPTIONS                   *******************');
display('    *************************************************************************************************');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% protocol on will document every single contribution - there will be just 10 'compound events'
protocol_on = true    % will document every single new contribution in detail
%protocol_on = false  % for m > 6 it is recommended to use protocol_on = false

%update_contributions = @(contributions,tie_options,payoff,cont) (contributions(tie_options,payoff)+cont);

contributions(m,m+2)=-x(m);   % initialization - guaranties that contributions will be a field of the class "sym" for symbolic
contributions(m,m+2)=0;       % initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% contributions to winning probalities require at least the payoff of 2
%% this payoff could be found in all rows - except for rows 2 and 3
%% Furthermore the payoff of 2 is in element (1,1) of the payoff matrix and otherwise always in column 3

% % A8 =
% % 
% %      2     4     4     4     4     4     4     4
% %      0     3     5     5     5     5     5     5
% %      0     1     4     6     6     6     6     6
% %      0     1     2     5     7     7     7     7
% %      0     1     2     3     6     8     8     8
% %      0     1     2     3     4     7     9     9
% %      0     1     2     3     4     5     8    10
% %      0     1     2     3     4     5     6     9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lets first consider payoff of 2 which is of 2-type (because it only occurs in two columns)
payoff = 2;

% % A8 =
% % 
% %      2     .     .     .     .     .     .     .
% %     (0)    .     .     .     .     .     .     .
% %     (0)   (1)    .     .     .     .     .     .
% %      .     .     2     .     .     .     .     .
% %      .     .     2     .     .     .     .     .
% %      .     .     2     .     .     .     .     .
% %      .     .     2     .     .     .     .     .
% %      .     .     2     .     .     .     .     .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%% before we make the loop  -  don't forget the very special case: option 1 is winning with payoff 2 

%contributions(1,2) = x1^2*(x1 + x2)^6         % for the special case m = 8
contributions(1,2) = x1^2*(x1 + x2)^(m-2)      % for the general case
event_count = 1;                               % for counting the events

f1 = [x1, x1];       % ATTENTION - we always have to multiply with x1 ------- it cannot get worse than payoff 2
f2 = [s2, x3];       % if loosing in one of rows 4...8 this occurs with s2 , tieing against the payoff 2 occurs with x3

%otie = [ 1 4 5 6 7 8 9];   % would be for m = 9
%otie = [ 1 4 5 6 7 8];     % would be for m = 8
otie = [1 (4:m)];           % the payoff of 2 can be found in any row, except for row 2 and 3
smult = [x1*s2];            % the combined probablity that in rows 2 and 3 both receive less than payoff 2

kk=m-3;                     % (m-3) is the number of "2" in column 3 - compare the matrix above (for m=8 we have 5 entries in 3rd column)

ties = [mod(1:(2^kk)-1,2)]; % this is a vector where 1 and 0 alternate
for kkk = 2:kk
   ties=[ties;mod(1:(2^kk)-1,2^kkk)>(2^(kkk-1)-1)]; % we then add a vector where 11 and 00 alternate - then 1111 and 0000 and so on
end
ties = ties';               % for (m=8) this is a matrix 31x5 starting with [1 0 0 0 0; ...] ending with [1 1 1 1 1]

%ties = [mod(1:31,2);mod(1:31,4)>1;mod(1:31,8)>3;mod(1:31,16)>7;mod(1:31,32)>15]'  % this is for 5 ties
%ties = [mod(1:63,2);mod(1:63,4)>1;mod(1:63,8)>3;mod(1:63,16)>7;mod(1:63,32)>15;mod(1:63,64)>31]'

ties = [ones((2^kk)-1,1),ties];   % this will add a "1" in front because with a payoff 2 - option 1 cannot loose
%ties = [ones(31,1),ties];   % for m=8  - this will add a one in front because with a payoff 2 - option 1 cannot loose
%ties = [ones(63,1),ties];   % for m=9  - this will add a one in front because with a payoff 2 - option 1 cannot loose

for ii=1:(2^(m-3)-1)                % with 8 options it runs to 31  ----    with 9 options it runs to 63    
    
    divisor = sum(ties(ii,:));
    cont1 = (1/divisor) * smult * f1(ties(ii,1)+1); 
    cont2 = 1;   
    for kk=2:m-2
         cont2 = f2(ties(ii,kk)+1)*cont2;
    end
    
    cont = cont1*cont2;      % this will be the final contribution
    ff=find(ties(ii,:)==1);  % these are all the elemments to add contribution
    tie_options = otie(ff);  % these are the options that tie simultaneously

    %contributions(otie(ff),2)=contributions(otie(ff),2)+cont,
    update_contributions;   %contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% now we finish with payoff 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];

%% now we calculate contributions for payoff 3
payoff = 3;
display('    *************************************************************************************************');
display('************                      START FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

% % A8 =
% % 
% %     (2)    .     .     .     .     .     .     .
% %      .     3     .     .     .     .     .     .
% %     (0)   (1)    .     .     .     .     .     .
% %     (0)   (1)   (2)    .     .     .     .     .
% %      .     .     .     3     .     .     .     .
% %      .     .     .     3     .     .     .     .
% %      .     .     .     3     .     .     .     .
% %      .     .     .     3     .     .     .     .

f1 = [x1, x2];       %     in row 2 we are smaller than payoff 3 with probability x1, we are exactly at payoff 3 with probability x2
f2 = [s3, x4];       %     in row (5:m) we are smaller than payoff 3 with probability s3, we are exactly at payoff 3 with probability x4

%otie = [ 2 5 6 7 8 9];   % would be for m = 9
%otie = [ 2 5 6 7 8];     % would be for m = 8
otie = [2 (5:m) ];

smult = [x1*s2*s3]        % this is the combined probability that in rows 1,3, and 4 we remain under they payoff 3 (see brackets in matrix above)
ties = ties(:,2:end);     % we can simply use again what was already calculated before for the payoff of 2 .... for (m=8) this is a matrix 31x5

%for ii=1:(2^(m-3)-1)                % with 8 options one has 31 lines
for ii=1:(2^(m-3)-1)                 % with 9 options one has 63 lines
    
    divisor = sum(ties(ii,:));
    
    cont1 = (1/divisor) * smult * f1(ties(ii,1)+1); 
    cont2 = 1;   
    for kk=2:m-3
         cont2 = f2(ties(ii,kk)+1)*cont2;
    end
    
    cont = cont1*cont2;    % this will be the final contribution

    ff=find(ties(ii,:)==1);  % these are all the elemments to add contribution
    tie_options = otie(ff);  % these are the options that tie simultaneously
    update_contributions;    %contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 
    %contributions(otie(ff),3)=contributions(otie(ff),3)+cont;  .... would have the same effect - but would not protocol the change
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% special cases: if m´= 3  and if m = 2

if (m==3)
    contributions(2,3)=contributions(2,3)+ x1* x2 * s2,
    event_count = event_count+1;
end

if (m==2)
    contributions(2,3)=contributions(2,3)+ x1* x2,
    event_count = event_count+1;
end

display('contributions for the payoff 3 - only');
contributions(:,3),

display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end for payoff 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lets now consider payoff of 4 - the most complicated one (eventually 3-type)
% in general payoff should run from 4 to m-2 ... those payoffs are all three-type

for payoff = 4:m-2          % in case of m=8 we need to do it for 4,5 and 6    
display('    *************************************************************************************************');
display('************                      START FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');


%% for m=8 and the payoff of 4 we woud need the following:
% f1 = [s(1), (1-s(1))];    % in row 1 we are smaller than payoff 4 with probability x1, we are exactly at payoff 4 with probability (1-x1)
% f2 = [s(2), x(3)];        % in row 3 we are smaller than payoff 4 with probability s2, we are exactly at payoff 4 with probability x3
% f3 = [s4, x5];            % in row 6...8 we are smaller than payoff 4 with probability s4, we are exactly at payoff 4 with probability x5

%% for general m and payoffs the same looks as follows:
f1 = [s(payoff-3), (1-s(payoff-3))];  
f2 = [s(payoff-2), x(payoff-1)];       
f3 = [s(payoff), x(payoff+1)];  

% otie = [ 1 3 6 7 8 9];    % for m=9 and the payoff of 4 
% otie = [ 1 3 6 7 8];      % for m=8 and the payoff of 4 
%% for general m and the payoff of 4 
% otie   = [    1         3          (6:m)]
otie   = [(payoff-3) (payoff-1) (payoff+2:m)]       % this will display also the options that can tie simultaneously
nrties = numel(otie);  


% % A8 =
% % 
% %      .     4     4     4     4     4     4     4
% %     (0)   (3)    .     .     .     .     .     .      % with prob s2 < 4
% %      .     .     4     .     .     .     .     .
% %     (0)   (1)   (2)    .     .     .     .     .      % with prob s3 < 4
% %     (0)   (1)   (2)   (3)    .     .     .     .      % with prob s4 < 4
% %      .     .     .     .     4     .     .     .
% %      .     .     .     .     4     .     .     .
% %      .     .     .     .     4     .     .     .

%% therefore smult as multiplication of (row2<4)*(row4<4)*(row5<4)
%smult = [s(2)*s(3)*s(4)]                        % for the specific payoff of 4
smult = [s(payoff-2)*s(payoff-1)*s(payoff)];     % for general payoffs >= 4

kk=nrties;   % remember the number of ties

ties = [mod(1:(2^kk)-1,2)];
for kkk = 2:kk
   ties=[ties;mod(1:(2^kk)-1,2^kkk)>(2^(kkk-1)-1)];
end
ties = ties';

%ties = [mod(1:31,2);mod(1:31,4)>1;mod(1:31,8)>3;mod(1:31,16)>7;mod(1:31,32)>15]'  % this is for 5 ties
%ties = [mod(1:63,2);mod(1:63,4)>1;mod(1:63,8)>3;mod(1:63,16)>7;mod(1:63,32)>15;mod(1:63,64)>31]'

%for ii=1:(2^(m-3)-1)                % with 8 options it gos to 31
for ii=1:size(ties,1)                % with 9 options it gos to 63    
    
    divisor = sum(ties(ii,:));
    
    cont1 = (1/divisor) * smult * f1(ties(ii,1)+1) * f2(ties(ii,2)+1); 
    cont2 = 1;   
    for kk=3:nrties
         cont2 = f3(ties(ii,kk)+1)*cont2;
    end
    
    cont = cont1*cont2;    % this will be the final contribution

    ff=find(ties(ii,:)==1);  % these are all the elemments to add contribution
    %contributions(otie(ff),4)=contributions(otie(ff),4)+cont;
    tie_options = otie(ff);  % these are the options that tie simultaneously
    update_contributions;    %contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 
        
end

disp('*************************************************************************************************');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remark: the last row of "ties" consists exclusively of ones - we use this to display the critical event
eventmult = [x(payoff-2)*x(payoff-1)*x(payoff)];     % for general payoffs >= 4

%% because last row corresponds to the maximal number of ties - we need not to calculate again
display('probability of the critical_event for the payoff of: ' + string(payoff));
critical_event = (cont/smult)*eventmult,             % this is the critical_event according to Definition 5

display('summary of all contributions for the payoff  ' + string(payoff));
contributions(:,payoff),

display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];

end       % for poff = 4:m-2
display('*************************************************************************************************');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% now we are finish with payoffs 4 .... (m-2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% now there are only type 2 cases - and the most simple second-last line

% % % % % % % 
% % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % % % % % % %% special cases: if m´= 3  and if m = 2
% % % % % % % 
% % % % % % % if (m==3)
% % % % % % %     contributions(2,3)=contributions(2,3)+ x1* x2 * s2,
% % % % % % % end
% % % % % % % 
% % % % % % % if (m==2)
% % % % % % %     contributions(2,3)=contributions(2,3)+ x1* x2,
% % % % % % % end
% % % % % % % 
% % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % %% end for payoff 3
% % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%+++++++  payoffs 7 - 8 - 9  will be much simpler - because only two options can tie   ++++++++
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% % A8 =
% % 
% %      2     4     4     4     4     4     4     4
% %      0     3     5     5     5     5     5     5
% %      0     1     4     6     6     6     6     6
% %      0     1     2     5     7     7     7     7
% %      0     1     2     3     6     8     8     8
% %      0     1     2     3     4     7     9     9
% %      0     1     2     3     4     5     8    10
% %      0     1     2     3     4     5     6     9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% now all contributions with a payoff of 7 (in general m-1) --- there will be only two types 

% only with option 4 an 6 possible to get a payoff of 7

% remains options 5,7, and 8 
%sx7 = [s5*s6*s7];  % now we make this multiplier general

if (m>4)

smult = [s(m-3)*s(m-2)*s(m-1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% both options tie for the special case (m=8) - it is commented out - but might be helpful to understand the general case (m>4)
% contributions(4,7) = contributions(4,7) + (1/2) * [sx7] * (1-s4) * x6;     
% contributions(6,7) = contributions(6,7) + (1/2) * [sx7] * (1-s4) * x6;     

%% both options tie - for the general case (m>4)
%contributions(m-4,m-1) = contributions(m-4,m-1) + (1/2) * [smult] * (1-s(m-4)) * x(m-2);     
%contributions(m-2,m-1) = contributions(m-2,m-1) + (1/2) * [smult] * (1-s(m-4)) * x(m-2);     

payoff = m-1; cont = (1/2) * [smult] * (1-s(m-4)) * x(m-2);
tie_options = [m-4, m-2]; % exactly two options tie
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

%---------------------------
% finally the 2 cases where we have a clear winner with payoff 7 - all other options loose 
% option 4 wins                                     [sx7] * (1-s4) * s5  
% option 6 wins                                     [sx7] * (s4)   * x6

% contributions(4,7) = contributions(4,7) + [sx7] * (1-s4) * s5;    
% contributions(6,7) = contributions(6,7) + [sx7] * (s4)   * x6;

%contributions(m-4,m-1) = contributions(m-4,m-1) +  [smult] * (1-s(m-4)) * s(m-3);     
%contributions(m-2,m-1) = contributions(m-2,m-1) +  [smult] * (s(m-4)) * x(m-2);     

tie_options = m-4; cont = [smult] * (1-s(m-4)) * s(m-3); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

tie_options = m-2; cont = [smult] * (s(m-4)) * x(m-2); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

display('contributions for the payoff  ' + string(m-1));
contributions(:,m-1),   % contributions(:,payoff),

display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];

end  %% if (m>4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% now all contributions with a payoff of 8 (in general payoff m) --- there will be only two types 
% only with option 5 and 7 possible to get a payoff of 8

% remains options 6 and 8 
% sx8 = [s6*s7];  % now we make this multiplier general
% smult = [s(6)*s(7)];  % now we make this multiplier general

if (m>3)

smult = [s(m-2)*s(m-1)],

%%%%%%%%%%%%%%%%%%%
%% both options tie
% % contributions(5,8) = contributions(5,8) + (1/2) * [sx8] * (1-s5) * x7;     
% % contributions(7,8) = contributions(7,8) + (1/2) * [sx8] * (1-s5) * x7;     

%% both options tie
%contributions(m-3,m) = contributions(m-3,m) + (1/2) * [smult] * (1-s(m-3)) * x(m-1);     
%contributions(m-1,m) = contributions(m-1,m) + (1/2) * [smult] * (1-s(m-3)) * x(m-1);   

payoff = m; cont = (1/2) * [smult] * (1-s(m-3)) * x(m-1); 
tie_options = [m-3, m-1]; % exactly two options tie
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

%---------------------------
% finally the 2 cases where we have a clear winner with payoff 8 - all other options loose 

% contributions(5,8) = contributions(5,8) + [sx8] * (1-s5) * s6;    
% contributions(7,8) = contributions(7,8) + [sx8] * (s5)   * x7;

%contributions(m-3,m) = contributions(m-3,m) +  [smult] * (1-s(m-3)) * s(m-2);     
%contributions(m-1,m) = contributions(m-1,m) +  [smult] * (s(m-3)) * x(m-1);   

tie_options = m-3; cont = [smult] * (1-s(m-3)) * s(m-2); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

tie_options = m-1; cont = [smult] * (s(m-3)) * x(m-1); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

display('contributions for the payoff  ' + string(m));
contributions(:,m),   % contributions(:,payoff),

display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];

end     % if (m>3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% now all contributions with a payoff of 9 (in general m+1) --- there will be only two types 

% only with option 6 and 8 possible to get a payoff of 9

% remains option 7
% sx9 = [s7];  % now it would be nonsense to introduce sx9

%%%%%%%%%%%%%%%%%%%
% % %% both options tie
% % contributions(6,9) = contributions(6,9) + (1/2) * [s7] * (1-s6) * x8;     
% % contributions(8,9) = contributions(8,9) + (1/2) * [s7] * (1-s6) * x8;     

if (m>2)

%% both options tie
%contributions(m-2,m+1) = contributions(m-2,m+1) + (1/2) * [s(m-1)] * (1-s(m-2)) * x(m),    
%contributions(m,m+1)   = contributions(m,m+1)   + (1/2) * [s(m-1)] * (1-s(m-2)) * x(m),     

payoff = m+1; cont = (1/2) * [s(m-1)] * (1-s(m-2)) * x(m);
tie_options = [m-2, m]; % exactly two options tie
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

%---------------------------
% finally the 2 cases where we have a clear winner with payoff 9 - all other options loose 
% 
% contributions(6,9) = contributions(6,9) + [s7] * (1-s6) * s7;    
% contributions(8,9) = contributions(8,9) + [s7] * (s6)   * x8;

%contributions(m-2,m+1) = contributions(m-2,m+1) +  [s(m-1)] * (1-s(m-2)) * s(m-1),     
%contributions(m,m+1)   = contributions(m,m+1)   +  [s(m-1)] * (s(m-2)) * x(m),

tie_options = m-2; cont = [s(m-1)] * (1-s(m-2)) * s(m-1); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

tie_options = m; cont = [s(m-1)] * (s(m-2)) * x(m); % clear winner therefore no divisor 
update_contributions;   % contributions(tie_options,payoff) = contributions(tie_options,payoff)+cont, 

display('contributions for the payoff  ' + string(m+1));
contributions(:,m+1),   % contributions(:,payoff),

end    %  if (m>2)

display('    *************************************************************************************************');
display('************                        END FOR PAYOFF ' + string(payoff) +'                        *******************');
display('    *************************************************************************************************');

event_count,    % prints the number of events
ecount_list =  [ecount_list,event_count];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% most simple (for m=8) payoff 10 is only once in the table 
% finally the only case where we have a clear winner with payoff 10 - all other options loose 

% contributions(7,10) = contributions(7,10) + x8;  
contributions(m-1,m+2) = contributions(m-1,m+2) + x(m),
display('FINALLY the update for the number of events');
event_count = event_count + 1

if (m>2)   % for m=2 it is trivial - each payoff value 2,3,4 has one compound event
   display('How the number of compound events breaks down to payoffs');
   [2:m+2;diff(ecount_list),1]
end

% contributions(m-1,m+2)=a8;          %%% this is the highest possible payoff - wins always   

% % A8 =
% % 
% %      2     4     4     4     4     4     4     4
% %      0     3     5     5     5     5     5     5
% %      0     1     4     6     6     6     6     6
% %      0     1     2     5     7     7     7     7
% %      0     1     2     3     6     8     8     8
% %      0     1     2     3     4     7     9     9
% %      0     1     2     3     4     5     8    10
% %      0     1     2     3     4     5     6     9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% finaly the main diaginal because f = winprob(xx) - xx ...

%for ii = 1:m-1  
for ii = 1:m    
    contributions(ii,1) = -x(ii);
end

% contributions(1,1) = -x1;
% contributions(2,1) = -x2;
% ...
%contributions(8,1) = -x8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% now if we want to get a Jacobian we need to sum up the contributions

% % % 
% % % % % 
%s1=a1,s2=s1+a2,s3=s2+a3,s4=s3+a4,s5=s4+a5,s6=s5+a6,s7=s6+a7,          %s8=s7+a8
% 

s1=x1;s2=s1+x2;s3=s2+x3;s4=s3+x4;s5=s4+x5;s6=s5+x6;s7=s6+x7;s8=s7+x8;s9=s8+x9;s10=s9+x10;
s11=s10+x11;s12=s11+x12;s13=s12+x13;s14=s13+x14;s15=s14+x15;s16=s15+x16;s17=s16+x17;s18=s17+x18;s19=s18+x19;

if (m==20)
   %x20=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19)
   x20=1-(s19)
end

if (m==19)
   %x19=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17+a18)
   x19=1-(s18)
end

if (m==18)
   %x18=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17)
   x18=1-(s17)
end

if (m==17)
   %x17=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16)
   x17=1-(s16)
end

if (m==16)
   %x16=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15)
   x16=1-(s15)
end

if (m==15)
   %x15=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14)
   x15=1-(s14)
end

if (m==14)
   %x14=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13)
   x14=1-(s13)
end 

if (m==13)
   %x13=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12)
   x13=1-(s12)
end 

if (m==12)
   %x12=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11)
   x12=1-(s11)
end 

if (m==11)
   %x11=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9+a10)
   x11=1-(s10)
end 

if (m==10)
   %x10=1-(a1+a2+a3+a4+a5+a6+a7+a8+a9)
   x10=1-(s9)
end 

if (m==9)
   %x9=1-(a1+a2+a3+a4+a5+a6+a7+a8)
   x9=1-(s8)
end 

if (m==8)
   %x8=1-(a1+a2+a3+a4+a5+a6+a7)
   x8=1-(s7)
end

if (m==7)
   %x7=1-(a1+a2+a3+a4+a5+a6)
   x7=1-(s6)
end 

if (m==6)
   %x6=1-(a1+a2+a3+a4+a5)
   x6=1-(s5)
end 

if (m==5)
   %x5=1-(a1+a2+a3+a4)
   x5=1-(s4)
end

if (m==4)
   %x4=1-(a1+a2+a3)
   x4=1-(s3)
end 

if (m==3)
   %x3=1-(a1+a2)
   x3=1-(s2)
end

if (m==2)
   x2=1-(x1)
end

cont = eval(contributions);

c(m,1) = sum(cont(m,:));

for ii=1:m-1
   c(ii) = sum(cont(ii,:));    
end

% c1 = sum(cont(1,:));
%  ....
%  c9 = sum(cont(9,:));

JJ=[];

for ii=1:m-1
   JJ = [JJ,diff(c,x(ii))];         % taking the partial derivatives
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Finally we print the Jacobean dependent on symbolic values

Jac_mm = JJ(1:m-1,1:m-1)            % restricting the Jacobean to a square matrix (m-1)x(m-1)

%Jac77 = [J1(1:7);J2(1:7);J3(1:7);J4(1:7);J5(1:7);J6(1:7);J7(1:7)];
%Jac88 = [J1(1:8);J2(1:8);J3(1:8);J4(1:8);J5(1:8);J6(1:8);J7(1:8);J8(1:8)];
% % % % % %% 
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% in completeFKT we collect the right-hand-sides of equation xi_dot = f(\xi) for every action ai

% completeFKT = simplify([c1;c2;c3;c4;c5;c6;c7;c8;c9])
% save syms_contributions_all_payoffs_JAC88 Jac88 completeFKT

%completeFKT = simplify([c1;c2;c3;c4;c5;c6;c7;c8])

completeFKT = simplify(c)
save syms_contributions_all_payoffs
%save syms_contributions_all_payoffs_JACflex JJ completeFKT


